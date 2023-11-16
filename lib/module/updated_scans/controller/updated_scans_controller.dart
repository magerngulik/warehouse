// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_delete.dart';

import '../view/updated_scans_view.dart';

class UpdatedScansController extends GetxController {
  var log = Logger();

  @override
  void onInit() {
    super.onInit();
    checkIntiData();
  }

  UpdatedScansView? view;
  Map? data;

  UpdatedScansController({
    this.data,
  });

  //controller rak item
  final rakitemController = Get.put(RakLocationController());

  //loading
  // RxBool isLoading = false.obs;

  //data show to ui
  String partNumber = "";
  String partName = "";
  String headName = "";
  String updatedAt = "";

  String idUserLogin = "";
  String emailUser = "";
  String usernameUser = "";

  //box description allstock and statue
  int allStock = 0;
  String minim = "";
  int dataMinim = 0;
  int quantity = 0;
  String idUser = "";
  String userChange = "";

  // var id
  int idLocation = 0;
  int idPart = 0;
  int idTransaction = 0;

  checkIntiData() {
    if (data != null) {
      debugPrint("$data");
      log.d(data);

      var transaction = data!["transaction"][0];
      var part = transaction['part'];
      log.d(data);
      log.d(transaction);
      log.d(part);
      headName = data!['head_name'];
      partNumber = part!['part_number'];
      partName = part!['part_name'];
      updatedAt = data!['updated_at'];
      idUser = data!['id_user'];
      allStock = part!['stock'];
      dataMinim = part!['minimum'];
      quantity = data!['quantity'];

      if (allStock < dataMinim) {
        minim = "Minim";
      } else {
        minim = "Normal";
      }

      idLocation = data!['id'];
      idPart = part!['id'];
      idTransaction = transaction['id'];

      debugPrint("id location: $idLocation");
      debugPrint("id transcation: $idTransaction");
      debugPrint("id part: $idPart");

      getUserDetail();
      getUserChanges();
    }
  }

  updateViewDataPart() {
    Future.delayed(const Duration(seconds: 2));
  }

  showDialogDelete() {
    Get.dialog(QDialogDelete(
      message: "Apakah anda ingin menghapus data ini?",
      ontap: () async {
        debugPrint("delete data ya");

        await doDeleteItem();
        Get.back();
      },
    ));
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

      debugPrint("id user = $idUser");
      debugPrint("email user = $emailUser");
      debugPrint("username user = $usernameUser");
    } else {
      Get.offAll(const LoginView());
    }
  }

  getUserChanges() async {
    Future.delayed(const Duration(seconds: 1));
    try {
      final data =
          await supabase.from('user').select('*').eq("id", idUser).single();

      userChange = data['username'];
      print("data user change $data");
    } catch (e) {
      Get.dialog(QDialog(
        message: "Ada yang salah untuk data user, harap kembali login, $e",
        ontap: () {
          Get.offAll(const LoginView());
        },
      ));
    }
  }

  //untuk melakukan delete ke item yang tersedia
  doDeleteItem() async {
    Get.back();
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        debugPrint("delete di panggil");
        var newStrock = 0;
        debugPrint("tahapan update data part");
        debugPrint("all stock = $allStock");
        debugPrint("quantity = $quantity");
        debugPrint("new Stock = $newStrock");

        if (allStock >= quantity) {
          //stock jalan
          debugPrint("stock jalan");
          newStrock = allStock - quantity;
        } else {
          debugPrint("stock tidak jalan");

          await Get.dialog(QDialog(
            message:
                "Data stock kurang dari quantity yang akan dihapus, harap cek lagi data ini, mungkin bisa di updated/ada kesalahan",
            ontap: () {
              Get.back();
            },
          ));
          return;
        }

        try {
          await supabase
              .from('part')
              .update({'stock': newStrock}).match({'id': idPart});
        } catch (e) {
          Get.dialog(QDialog(message: "error ketika update stock $e"));
          return;
        }

        //hapus quantity -> table location
        // - updata quantity location to zero = 0
        //di update karna akan di hapus dari location
        var quantityZero = 0;
        try {
          await supabase
              .from('location')
              .update({'quantity': quantityZero}).match({'id': idLocation});
        } catch (e) {
          Get.dialog(QDialog(message: "error ketika update quantity $e"));
          return;
        }

        //detail_transaction -> buat table baru
        // id_location
        // id part
        // stock sekarang
        // new stock
        // quantity location

        //hapus transaction -> teble transaction
        //- delete transaction id
        try {
          await supabase
              .from('transaction')
              .delete()
              .match({'id': idTransaction});
        } catch (e) {
          Get.dialog(QDialog(message: "error ketika delete transaction $e"));
          return;
        }

        try {
          //kode di bawah ini merupakan services untuk melakukan input history transaksi
          await WarehouseServices.addHistoryTransaction(
              partId: idPart,
              locationId: idLocation,
              quantity: quantityZero,
              stock: newStrock,
              description: "delete data",
              userId: idUserLogin);
        } catch (e) {
          Get.dialog(QDialog(
              message: "ada masalah saat mengupdate history transaksi, $e"));
          return;
        }

        rakitemController.getDataLocation();
        Get.back();
      },
    );
    //kurangi stock -> table part
    //- new stock = stock - quantity
    //- update new strok
  }
}
