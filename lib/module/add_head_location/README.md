# Halaman Add location view
pada halaman ini berfungsi untuk menambahkan data baru dan edit, data dari head_location, untuk tampilan dari halaman ini sebagai berikut:![add_head_location](/assets/image/menu_admin/add_head_location.png)

untuk penjalan dari koding nya sebagai berikut:
```dart
//pertama pada init kita panggil check data untuk check ada data yang di kirim atau tidak
@override
  void onInit() {
    super.onInit();
    checkData();
}

checkData() {
//disini akan cek apabila id nya 0
if (id != 0) {
  //ini akan set data dari itemuntuk mengambil beberapa string yang ada di daldam nya, data yangpenting adalah max lantai, max rak dan location name
  var item = data;
  debugPrint("data = $item");
  maxLantai.text = ite ["max_lantai"].toString();
  maxRak.text = item["max_rak"]toString();
  locationName.text = ite  ["location_name"];
}
}

```
- selanjutnya jika kondisi nya untuk menambahkan data baru sebagai berikut:
```dart

  addNewHeadLocation() {
    //disini akan check apakah max_lantai dan max_rak kosong atau tidak
    if (maxLantai.text == "" || maxRak.text == "") {
    //jika kedua textfield itu kosong maka akan menampilkan dialog
      Get.showSnackbar(
        const GetSnackBar(
          title: "Warning",
          message: 'Max Lantai atau Max Rak tidak boleh kosong',
          icon: Icon(Icons.warning, color: Colors.white),
          duration: Duration(seconds: 3),
        ),
      );
    }
    //selanjutnya akan cek apakah headlocation ini kosng jika kosong akan mendapatkan dulu head location ini, head_location ini akan berguna ketika ingin menambahkan data
    if (id != 0) {
      Get.showOverlay(
        loadingWidget: const Center(child: CircularProgressIndicator()),
        asyncFunction: () async {
          updatedHeadLocationTable(id);
        },
      );
    } else {
        //disiini akan menambahkan data baru berdasarkan max_lantain dan max_rak yang ada 
      try {
        createHeadLocationTable(
            int.parse(maxLantai.text), int.parse(maxRak.text));
      } catch (e) {
        //jika gagal akan menampilkan error
        debugPrint("error: ${e.toString()}");
      }
    }
  }


  //membuat table location baru
  Future<void> createHeadLocationTable(int maxLantai, int maxRak) async {
    //disni adkan mendapatkan lokasi data baru dan mendapatkan location name;
    var newLocation = await 
    getNextLocationName();
    // disini akan menampilkan loading
    Get.showOverlay(
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
      asyncFunction: () async {
        try {
          debugPrint("Kodingan berjalan");
          //dibagian ini akan menambahkan data baru dari tabel head_location
          await supabase.from('head_location').insert({
            'location_name': newLocation,
            'max_lantai': maxLantai,
            'max_rak': maxRak,
          });
          //jika berhasil screen ini akan di tutup
          Get.back();
        } catch (e) {
            //jika gagal akan print data error
          debugPrint(e.toString());
        }
      },
    );
  }
```
- kondisi ini untuk update data 
```dart
//melakukan editing tabel
  updatedHeadLocationTable(int id) async {
    //disini akan melakukan perubahan dari data yang dikirimkan di halaman sebelumnya yang sudah diload di get data
    try {
        //kode untuk update data
      await supabase.from("head_location").update({
        'max_lantai': maxLantai.text,
        'max_rak': maxRak.text,
      }).eq('id', id);
      //ditutup ketika berhasil
      Get.back();

    } catch (e) {
      //disini akan print error ketika gagal
      debugPrint(e.toString());
    }
  }
```
