// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';

import '../view/input_scans_view.dart';

class InputScansController extends GetxController {
  @override
  void onClose() {
    super.onClose();
    partNumberController.dispose();
    locationFieldController = "";
    quantityController.dispose();
  }

  final halamanRak = Get.put(RakLocationController());
  final halamanUpdated = Get.put(UpdatedScansController());

  InputScansView? view;
  Map? data;

  Map? dataUpdate;
  InputScansController({this.data, this.dataUpdate});

  //variable datang
  var partNumberController = TextEditingController();
  var locationFieldController = "";
  var idLocationController = 0;
  var quantityController = TextEditingController();

  int partNumberid = 0;
  int? stock;
  int newStock = 0;
  int idHead = 0;
  String headName = "";
  List<Map<String, dynamic>> dataLocationReady = [];

  //new data update
  int oldQuantity = 0;
  int oldStock = 0;
  //old ids
  int oldIdLocation = 0;
  int oldIdPart = 0;
  int oldIdTransaction = 0;

  //part number
  String oldPartNumber = "";
//user
  String idUserLogin = "";
  String emailUser = "";
  String usernameUser = "";

  var log = Logger();
  @override
  void onInit() {
    super.onInit();
    log.d(data);
    cekData();
    getDataHeadLocation();
    getDataLocation();
    getUserDetail();
  }

  getUserDetail() async {
    Future.delayed(const Duration(seconds: 1));
    var prefh = await SharedPreferences.getInstance();
    var services = SharedPreferencesService(prefh);

    var currentUserId = services.getString("uuid");
    var currentEmail = services.getString("email");
    var currentUsername = services.getString("username");
    var currentRole = services.getString("role");

    if (currentUserId != "" &&
        currentEmail != "" &&
        currentUsername != "" &&
        currentRole != "") {
      idUserLogin = currentUserId;
      emailUser = currentEmail;
      usernameUser = currentUsername;

      debugPrint("id user = $idUserLogin");
      debugPrint("email user = $emailUser");
      debugPrint("username user = $usernameUser");
    } else {
      Get.offAll(const LoginView());
    }
  }

  getDataHeadLocation() async {
    if (dataUpdate == null) {
      if (data!['head_location_id'] == 0) {
        await Future.delayed(const Duration(seconds: 3));
        Get.dialog(const QDialog(message: "gagal mendapatkan lokasi"));
      } else {
        idHead = data!['head_location_id'];
        debugPrint("id head: $idHead");
      }
    } else {
      log.f(dataUpdate);
      idHead = dataUpdate!['head_location_id'];

      var transaction = dataUpdate!["transaction"][0];
      var part = transaction['part'];
      debugPrint(transaction.toString());
      debugPrint(part.toString());
      partNumberController.text = part['part_number'];
      quantityController.text = dataUpdate!['quantity'].toString();
      headName = dataUpdate!['head_name'];

      //math
      oldQuantity = dataUpdate!['quantity'];
      oldStock = part['stock'];
      oldPartNumber = part['part_number'];

      oldIdLocation = dataUpdate!['id'];
      oldIdTransaction = transaction['id'];
      oldIdPart = part['id'];
    }
  }

  doUpdate() async {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        if (oldPartNumber == partNumberController.text) {
          debugPrint("par numner sama");

          if (oldQuantity < int.parse(quantityController.text)) {
            //untuk mendapatkan new quantity
            //jika nilai quantity lebih kecil dari sebelum nya maka seperti ini
            // old quantity = 20
            // new quantity controller = 21
            int newQuantity = int.parse(quantityController.text) - oldQuantity;
            //pada bagian ini akan melakukan update pada tabel location dan melakukan update pada quantity yang ada pada tabel location
            int newStock = oldStock + newQuantity;
            //bagian ini ada proses untuk update data quantity
            try {
              Map dataChangeLocation = {"quantity": quantityController.text};

              await supabase
                  .from('location')
                  .update(dataChangeLocation)
                  .match({'id': oldIdLocation});
            } catch (e) {
              Get.dialog(QDialog(
                  message: "Terjadi masalah saat updated location data: $e"));
              return;
            }

            //pada bagian ini kan melakukan update pada bagian tabel part dan akan melakukan update pada bagian stock pada tabel part
            //bagian ini ada proses untuk update data stock
            try {
              Map dataChangePart = {"stock": newStock};

              await supabase
                  .from('part')
                  .update(dataChangePart)
                  .match({'id': oldIdPart});
            } catch (e) {
              Get.dialog(QDialog(
                  message: "Terjadi masalah saat updated part data: $e"));
              return;
            }

            // snewQuantity = new quantity - old quantity
            //untuk mendapatkan new stock
            //stock = 32
            //snewQuantity = 1;
            //stock = stock + snewQuantity;
            //stok = 33
            debugPrint("new quantity $newQuantity");
            debugPrint("update quantity ${quantityController.text}");
            debugPrint("new stock $newStock");

            //selanjutnya akan menambahkan data detail transaction
            //di bagian ini: next akan di update

            //selanjutnya di sini akan membuka dialog bahwa data berhasil di update
            halamanUpdated.checkIntiData();

            try {
              await WarehouseServices.addHistoryTransaction(
                  partId: oldIdPart,
                  locationId: oldIdLocation,
                  quantity: newQuantity,
                  stock: newStock,
                  description: "update data",
                  userId: idUserLogin);
            } catch (e) {
              Get.dialog(QDialog(
                  message:
                      "ada masalah saat mengupdate history transaksi, $e"));
              return;
            }

            Get.dialog(QDialog(
              message: "Data berhasil di update",
              ontap: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ));
            return;
          } else {
            //jika number yang di akses lebih kecil
            //old quantity
            //new quantity
            // snewQuantity =

            int selisih = oldQuantity - int.parse(quantityController.text);
            int snewStock = oldStock - selisih;

            debugPrint("nilai old quantity = $oldQuantity");
            debugPrint("nilai old sekarang = ${quantityController.text}");
            debugPrint("nilai selisih : $selisih");
            debugPrint("nilai old stock $oldStock");
            debugPrint("nilai new stock $snewStock");

            debugPrint(
                "quantity yang akan di updated = ${quantityController.text}");
            debugPrint("stock yang akan di updated = $snewStock");
            //update data quantity
            try {
              Map dataChangeLocation = {"quantity": quantityController.text};

              await supabase
                  .from('location')
                  .update(dataChangeLocation)
                  .match({'id': oldIdLocation});
            } catch (e) {
              Get.dialog(QDialog(
                  message: "Terjadi masalah saat updated location data: $e"));
              return;
            }

            // update data stock
            try {
              Map dataChangePart = {"stock": snewStock};

              await supabase
                  .from('part')
                  .update(dataChangePart)
                  .match({'id': oldIdPart});
            } catch (e) {
              Get.dialog(QDialog(
                  message: "Terjadi masalah saat updated part data: $e"));
              return;
            }

            try {
              await WarehouseServices.addHistoryTransaction(
                  partId: oldIdPart,
                  locationId: oldIdLocation,
                  quantity: int.parse(quantityController.text),
                  stock: snewStock,
                  description: "update data",
                  userId: idUserLogin);
            } catch (e) {
              Get.dialog(QDialog(
                  message:
                      "ada masalah saat mengupdate history transaksi, $e"));
              return;
            }

            halamanUpdated.checkIntiData();

            Get.dialog(QDialog(
              message: "Data berhasil di update",
              ontap: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ));
            return;
          }
          //kondisi di bawah ini tidak berjalan ada bug yang harus di perbaiki
        } else {
          try {
            await cekPartNumber(partNumber: partNumberController.text);
          } catch (e) {
            Get.dialog(QDialog(
                message: "Terjadi masalah saat mengambil part data: $e"));
            return;
          }
          if (partNumberid == 0) {
            Get.dialog(
                const QDialog(message: "Part Number yang anda masukan salah"));
            return;
          }

          //jika part number berbeda yang akan di lakukan adalah
          //1. update tabel transaction rubah id_part yang ada pada tabel

          Map dataChangePart1 = {"part_id": partNumberid};
          try {
            await supabase
                .from('transaction')
                .update(dataChangePart1)
                .match({'id': oldIdTransaction});
          } catch (e) {
            Get.dialog(QDialog(
                message: "Terjadi masalah saat updated transaction data: $e"));
            return;
          }

          int nNewQuantity = 0;
          int nNewStock = 0;
          int currentQuantity = int.parse(quantityController.text);
          //2. check dulu beberapa kondisi yang akan terjadi
          // - jika tidak ada perubahan pada stock
          // - jika ada perubahan
          //   - jika data lebih dari
          //   - jika data kurang dari
          debugPrint("nilai current quantity: $currentQuantity");
          debugPrint("nilai old quantity : $oldQuantity");
          if (oldQuantity == currentQuantity) {
            debugPrint("kondisit pertama");
            nNewQuantity = currentQuantity;
            nNewStock = oldStock;
          } else if (oldQuantity > currentQuantity) {
            debugPrint("kondisi kedua");
            var selisih = oldQuantity - currentQuantity;
            nNewStock = oldStock - selisih;
            nNewQuantity = currentQuantity;
          } else {
            debugPrint("kondisi ketiga");
            var selisih = currentQuantity - oldQuantity;
            nNewQuantity = currentQuantity + selisih;
            nNewStock = oldStock + selisih;
          }

          //3. dengan stock dan quantity yang ada yang akan di lakukan adalah
          //kurangai jumlah stock yang ada sekarang, dengan jumlah stock yang ada pada tabel part
          // setelah di kurangi jumlah stock tambahkan, stock saat ini ke part dan location yang baru, untuk part yang akan dilakukan adalah update column stock dan quantity.

          debugPrint("nilai new stock: $nNewStock");
          debugPrint("nilai new quantity: $nNewQuantity");

          //kurangi nilai stock lama dengan nilai stock yang sekarang
          //tambahkan nilai stock lama ke yang baru

          Map oldPartData = {"stock": 0};

          try {
            await supabase
                .from('part')
                .update(oldPartData)
                .match({'id': oldIdLocation});
          } catch (e) {
            Get.dialog(
                QDialog(message: "Terjadi masalah saat updated part data: $e"));
            return;
          }

          int newStockData = stock! + nNewQuantity;

          Map newPartData = {"stock": newStockData};

          await supabase
              .from('part')
              .update(newPartData)
              .match({'id': partNumberid});

          Get.dialog(QDialog(
            message: "Data berhasil di input",
            ontap: () {
              Get.back();
              Get.back();
              Get.back();
            },
          ));
          //kurangi kuantity yang lama ke yang baru
          //tambahkan kuantity yang lama ke yang baru
        }
      },
    );
  }

  cekData() {
    if (data == null) {
      log.d("data kosong");
    } else {
      log.d(data);
    }
  }

  scanPartNumber() async {
    partNumberController.text = await showQrcodeScanner(Get.context!) ?? "";
    debugPrint("part number : ${partNumberController.text}");
    update();
  }

  getDataLocation() async {
    Future.delayed(const Duration(seconds: 2));
    if (idHead != 0) {
      try {
        var datasorces = await supabase
            .from("location")
            .select("*")
            .eq("quantity", 0)
            .eq("head_location_id", idHead);
        debugPrint("ready data: $datasorces");
        log.d(datasorces);
        dataLocationReady = List<Map<String, dynamic>>.from(datasorces);

        update();
        debugPrint("ini data location; $dataLocationReady");
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Get.dialog(const QDialog(message: "gagal mendapatkan head id"));
    }
  }

  cekSubmit() async {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        debugPrint("part number: ${partNumberController.text}");
        debugPrint("location: $locationFieldController");
        debugPrint("quantity: ${quantityController.text}");

        if (partNumberController.text == "") {
          Get.dialog(
              const QDialog(message: "Data part number tidak boleh kosong"));
          return;
        } else if (locationFieldController == "") {
          Get.dialog(const QDialog(message: "Data lokasi tidak boleh kosong"));
          return;
        } else if (quantityController.text == "") {
          Get.dialog(
              const QDialog(message: "Data Quantity tidak boleh kosong"));
          return;
        }
        await cekPartNumber(partNumber: partNumberController.text);

        if (partNumberid == 0) {
          Get.dialog(
              const QDialog(message: "Part Number yang anda masukan salah"));
          return;
        }

        Map dataInput = {
          "location_id": idLocationController,
          "part_id": partNumberid
        };

        await supabase.from('transaction').insert(dataInput);

        await supabase
            .from('location')
            .update({'quantity': int.parse(quantityController.text)}).match(
                {'id': idLocationController});

        if (stock != null) {
          newStock = (stock ?? 0) + int.parse(quantityController.text);
          update();
        }
        debugPrint("new stock= $newStock");

        await supabase
            .from("part")
            .update({"stock": newStock}).match({"id": partNumberid});

        var quantityHistory = int.parse(quantityController.text);

        try {
          await WarehouseServices.addHistoryTransaction(
              partId: partNumberid,
              locationId: idLocationController,
              quantity: quantityHistory,
              stock: newStock,
              description: "add new data",
              userId: idUserLogin);
        } catch (e) {
          Get.dialog(QDialog(
              message: "ada masalah saat mengupdate history transaksi, $e"));
          return;
        }

        halamanRak.getDataLocation();
        Get.dialog(QDialog(
          message: "Data berhasil di input",
          ontap: () {
            Get.back();
            Get.back();
            Get.back();
          },
        ));
      },
    );
  }

  cekPartNumber({required String partNumber}) async {
    try {
      var response = await supabase
          .from("part")
          .select("id,stock")
          .eq("part_number", partNumber)
          .single();

      // Periksa apakah data kosong
      if (response.isEmpty) {
        Get.dialog(const QDialog(
            message: "Part number yang ada masukan tidak di temukan"));
      } else {
        partNumberid = response['id'];
        stock = response['stock'];
        debugPrint(partNumber);
        debugPrint("response stock ${response['stock']}");
        update();
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print("Terjadi kesalahan: $e");
    }
  }
}
