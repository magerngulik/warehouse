# Halaman input Scans View
Halaman ini terbagi menjadi 3 bagian yaitu untuk add, update dan search, perbedaan dari ketiga ini cuma berbeda untuk set data pada textfield yang ada.

Untuk memulai akan membuat beberapa variable untuk textfield beberapa controller sebagai berikut:
```dart
  //data di bawah ini merupakan beberap textfield yang akan di set, berupa controller
  var partNumberController = TextEditingController();
  var locationFieldController = "";
  var idLocationController = 0;
  var quantityController = TextEditingController();
  var searchTextfieldController = TextEditingController();

  //data untuk part number berfungsi pada bagian set textfield pada on init
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
  //location search
```

Selanjutnya kita akan melihat bagian on init, ada beberapa data yang akan di load di awal ketika screen ini dijalankan

```dart
  void onInit() {
    super.onInit();
    //berfungsi untuk melihat data nya kosong atau tidak
    cekData();
    //berfungsi ketika ada data yang datang baik dari search dan edit
    getDataHeadLocation();
    //data location ini berfungsi untuk mendapatkan data location dari idHead yang telah di berikan
    getDataLocation();
    //mengambil data ari local variable yang sudah diset pada halaman login
    getUserDetail();
  }
```
untuk penjelasan lengkap dari masing msing varible di atas adalah sebagai beriku:
__cek data__
```dart
  //sederhana nya variable ini akan check apakah data nya kosong atau tidak, jika varible nya berisi akan menampilkan log nya saja
  cekData() {
    if (data == null) {
      log.d("data kosong");
    } else {
      log.d(data);
    }
  }
  
```
__Get head location__
```dart
//sederhana nya pada bagian ini akan megambil head location jika screen ini di buka dari edit atau search
getDataHeadLocation() async {
  //cek data update null 
    if (dataUpdate == null) {
      if (dataSearch != null) {
        //cek apakah data search ada
        //jika ada ambil data dari dataSearch
        idHead = dataSearch!['head_location_id'];
        idLocationController = dataSearch!['id'];
        searchTextfieldController.text = dataSearch!['head_name'];
      } else {
        //jika data nya tidak ada makan akan menampilkan dialog gagal
        if (data!['head_location_id'] == 0) {
          await Future.delayed(const Duration(seconds: 3));
          Get.dialog(const QDialog(message: "gagal mendapatkan lokasi"));
        } else {
          //jika ada makan set data id head
          idHead = data!['head_location_id'];
          debugPrint("id head: $idHead");
        }
      }
    } else {
    //berjalan ketika data update ada
    //fungsi di bawah ini berfungsi ketika mapping dari data update tersedia dan mengambil berdasarkan bagian yang ada.
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

```
fungsi pada bagian ini akan digunakan di dalam view dan memeriksa apakah textfield yang ada sudah terisi atau belum
```dart
cekSubmit() async {
  //tampilkan loading
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        debugPrint("part number: ${partNumberController.text}");
        debugPrint("location: $locationFieldController");
        debugPrint("quantity: ${quantityController.text}");

        //cek apakah part number kosong
        if (partNumberController.text == "") {
          //jika kosong tampilkan dialog
          Get.dialog(
              const QDialog(message: "Data part number tidak boleh kosong"));
          return;
          //cek apakah location controller kosong
        } else if (locationFieldController == "") {
          //jika dataSearch kosong maka tampilkan dialog data kosong
          if (dataSearch == null) {
            Get.dialog(
                const QDialog(message: "Data lokasi tidak boleh kosong"));

            return;
          }
          //cek apakah quantity kosong
        } else if (quantityController.text == "") {
          //jika kosong tampilkan dialog data quantity kosong
          Get.dialog(
              const QDialog(message: "Data Quantity tidak boleh kosong"));
          return;
        }
        //untuk mengambil data part number yang di tuju
        await cekPartNumber(partNumber: partNumberController.text);
        //di bagian ini akan cek apakah part number kosong 
        if (partNumberid == 0) {
          //jika kosong tampilkan dialog
          Get.dialog(
              const QDialog(message: "Part Number yang anda masukan salah"));
          return;
        }

        //apabila semua kondisi di atas berhasil di lalui maka akan set data mapping untuk di input ke supabase
        Map dataInput = {
          "location_id": idLocationController,
          "part_id": partNumberid
        };
        //data input di insert ke tabel transaction
        await supabase.from('transaction').insert(dataInput);
        //dibagian ini akan melakukan seleksi ke tabel location dan melakukan update berdasarkan idlocation yang di berikan
        await supabase
            .from('location')
            .update({'quantity': int.parse(quantityController.text)}).match(
                {'id': idLocationController});
        //cek apabalia stock tidak kosng maka akan menambahkan stock yang ada dengan stock baru kemudian update data

        if (stock != null) {
          newStock = (stock ?? 0) + int.parse(quantityController.text);
          update();
        }
        debugPrint("new stock= $newStock");

        //dibagian ini akan melakukan upate data berdasrkan data stock baru
        await supabase
            .from("part")
            .update({"stock": newStock}).match({"id": partNumberid});

        var quantityHistory = int.parse(quantityController.text);

        //pada bagian ini akan menambahkan ke data history transaction berdarsarkan data yang sudah di set diatas
        try {
          await WarehouseServices.addHistoryTransaction(
              partId: partNumberid,
              locationId: idLocationController,
              quantity: quantityHistory,
              stock: newStock,
              description: "add new data",
              userId: idUserLogin);
        } catch (e) {
          //jika gagal maka akan menampilkan dialog gagal di tambahkan
          Get.dialog(QDialog(
              message: "ada masalah saat mengupdate history transaksi, $e"));
          return;
        }
        //di bagian ini ketika proses berhasil dan menampilkan dialog berhasil
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
```