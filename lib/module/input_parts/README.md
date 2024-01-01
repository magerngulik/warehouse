# Halaman Input Part 
pada halaman ini akan handle untuk bagian add new part dan edit part, untuk tampilan dari halaman ini adalah sebagai berikut:
![input_part](/assets/image/menu_admin/input_part.png)

karna bentuk nya untuk menambahkan dan edit data tentu saja akan ada beberapa variable untuk menampung nya seperti texteditingController sebagai berikut:
- definisi variable
```dart
 TextEditingController productNumberController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController minimalStockController = TextEditingController();
  int? idPart;
  bool isLoading = false;
```
- on init akan meload data di awal screen di buat, maka akan mengambil data dan set data ke variable yang di sediakan untuk bagian update
```dart
  @override
  void onInit() {
    super.onInit();
    //cek apakah data yang dikrim ada atau tidak, jika tidak kosong maka akan di masukan ke variable yang sudah di set sebelumnya
    stockController.text = 0.toString();
    if (item != null) {
      log.w(item);
      productNumberController.text = item!['part_number'];
      productNameController.text = item!['part_name'];
      stockController.text = item!['stock'].toString();
      minimalStockController.text = item!['minimum'].toString();
      idPart = item!["id"];
    }
  }
```

- proses melakukan update
```dart

  doUpdate() async {
    debugPrint("kondisi update berjalan");

    try {
        //set maping data untuk di update
          Map dataChange = {
        "part_name": productNameController.text,
        "stock": stockController.text,
        "minimum": minimalStockController.text
      };

      debugPrint("ini part name ${productNameController.text}");
    //fungsi untuk update data
      await supabase.from('part').update(dataChange).match({'id': idPart});
    } catch (e) {
        //jika gagal kana menampikan dialog
      debugPrint(e.toString());
      if (e is PostgrestException) {
        final errorMessage = e.message;
        Get.dialog(QDialongNoEmpty(title: errorMessage));
      }
    }
    //get back 2x untuk menutup 2 halaman dan kembali ke halaman menu
    Get.back();
    Get.back();
  }
```
- proses input data baru
```dart
 inputPartData() async {
    String error = "";
    RegExp regex = RegExp(r'^-?[0-9]+$');
    //cek validatsi apakah ada data yang kosong, jika kosong di tampilkan dialog
    if (productNumberController.text == "" ||
        productNumberController.text.isEmpty) {
      error = "product number";
    } else if (productNameController.text == "") {
      error = "product name";
    } else if (stockController.text == "") {
      error = "stock";
    } else if (minimalStockController.text == "") {
      error = "minimum stock";
    } else if (!regex.hasMatch(stockController.text)) {
      error = "stock harus berupa angka";
    } else if (!regex.hasMatch(minimalStockController.text)) {
      error = "minimum stock harus berupa angka";
    }
    //cek untuk menampilkan dialog
    if (error.isNotEmpty) {
      Get.dialog(QDialongNoEmpty(title: error));
      return;
    }
    //cek apakah item nya null atau tidak
    if (item == null) {
      var test = item == null;
      debugPrint(test.toString());
      //jika null maka bearti kondisi item baru di tambahkan
      try {
        await supabase.from('part').insert({
          'part_number': productNumberController.text,
          'part_name': productNameController.text,
          'stock': stockController.text,
          'minimum': minimalStockController.text,
        });
        //jika berhasil tampilkan dialog berhasil
        Get.dialog(QDialog(
          message: "berhasil input data",
          ontap: () {
            Get.back();
            Get.back();
          },
        ));
        // Get.back();
      } catch (e) {
        //jika gagal tampilkan dialog gagal
        debugPrint(e.toString());
        if (e is PostgrestException) {
          final errorMessage = e.message;
          Get.dialog(QDialongNoEmpty(title: errorMessage));
        }
      }
    } else {
      debugPrint("kondisi update berjalan");
      //proses apanila untuk delete data
      if (item!['stock'] != int.parse(stockController.text)) {
        Get.dialog(QDialogDelete(
          message:
              "Apakah anda yakin untuk merubah stock yang ada, ini dapat mengakibatkan bug pada sistem",
          ontap: () {
            doUpdate();
          },
        ));
      } else {
        doUpdate();
      }
    }
  }
```
