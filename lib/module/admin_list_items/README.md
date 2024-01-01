# Halaman admin list items
Pada halaman ini adalah admin list part, tapi di file admin list items, seperti nya ada kesalahan ketika pembuat data, untuk jelasnya halaman ini adalah untuk menampikan halaman dari tabel part, untuk halaman nya sendiri di tampilkan menggunakna stream jadi tidak ada penggunaan data load secara manual. untuk tampilan nya sebagai berikut:
![admin_list_items](/assets/image/menu_admin/admin_list_item.png)

- bentuk tampilan data tabel part yang di load dari supabase, pada bagian view.
```dart
//ini adalah stream  untuk menadapatkan data dari tabel part
StreamBuilder(
    stream: WarehouseServices.getStream("part"),
    builder: (context, snapshot) {
    if (!snapshot.hasError) {}})
```
- delete data
```dart

  var isLOading = false;
    //menampilan dilog apakah akan delele data atau tidak
  showDialogDelete(int id) {
    Get.dialog(QDialogDelete(
      message: "Apakah anda yakin untuk menghapus data ini?",
      ontap: () {
        debugPrint("id yang akan di hapus: $id");
        onDeleteItem(id);
        Get.back();
      },
    ));
  }

  onDeleteItem(int id) async {
    //ketika dialog delete di pilih
    isLOading = true;
    update();
    //deley 2 detik
    await Future.delayed(const Duration(seconds: 2));
    debugPrint("ini akhir nya");
    try {
        //kode untuk hapus data dari supabase
      var data = await supabase.from('part').delete().match({'id': id});
      debugPrint(data);
      Get.dialog(const QDialog(message: "data berhasil di hapus"));
    } catch (e) {
      Get.dialog(const QDialog(message: "Terjadi error ketika hapus data"));
    }
    isLOading = false;
    update();
  }
```
- untuk menambah data baru akan di load ke halaman [input_part_view](../input_parts/README.md)
