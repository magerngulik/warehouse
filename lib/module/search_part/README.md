# Halaman Search Part
Pada halaman ini akan melakukan seleksi ke database berdasarkan data atau variable yang telah kita simpan di local storage pada bagian [search_setting](../search_setting/README.md)

Pada awal screen ini akan melakukan load pada localStorage dan mengisi variable yang di persiapkan sebelumnya

- langkah pertama set beberapa variable sebagai berikut
```dart
  //untuk menampilkan loading
  bool isLoading = false;
  //variable bawaan dari debouncer untuk set deley ketika class ini di bawa
  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 10));
  //textfield untuk serach controller
  var textSearch = TextEditingController();
  //logger untuk menampilkan debug 
  var log = Logger();
  //field ini untuk seleksi kondisi dari search yang sedang terjadi
  String fieldName = "";
  //cek ketika status ascending
  bool isAscending = false;
  //cek ketika status minim
  bool isMinim = false;
  //cek ketuka part fitter
  bool partFilters = true;
  //list ketika kondisi location yang di pilih
  var dataLocation = [];
  //list ketika kondisi part yang di pilih
  var dataPart = [];
```
- selanjutnya pada awal screen di buat maka akan meload local storage seperti di bawah ini
```dart
cekLocalStorage() async {
    //get depedencies dari sharedPrefernces
    var prefh = await SharedPreferences.getInstance();
    //masukan ke local storage ke dalam variable
    var local = SharedPreferencesService(prefh);

    //cek apakah ada key searchField di dalam local storage
    fieldName = local.getString("searchField");
    if (fieldName == "") {
    //jika local storage kosong maka akan di pilih default di part number dan beri part filter ke kondisi true
      fieldName = "Part Number";
      partFilters = true;

    } else if (fieldName == "Part Number") {
      //kondisi sebelumnya apabila data nya kosong, di kondisi ini ketika field name memiliki isi part number
      partFilters = true;
    } else {
      //kondisi ini ketika bukan part number dan berisi location, maka partfilter ini diisi ke false, kondisi bool ini berfungsi untuk cek ketika textfield di klik
      partFilters = false;
    }
    //disini untuk mengambil data dari local storage, jika kosong varialbel is acending dan isminim ini kana tetap pada definisi awal
    isAscending = local.getBool("isAcending");
    isMinim = local.getBool("isMinim");

    debugPrint("field name = $fieldName");
    debugPrint("is ascending = $isAscending");
    debugPrint("is minim = $isMinim");
    //setelah variable semua di isi akan melakukan update ke view
    update();
  }


  //selanjutnya akan panggil function di atas dalam oninit seperti berikut ini:
  @override
  void onInit() {
    super.onInit();
    cekLocalStorage();
  }

```
- setelah variable di set maka langkah selanjutnya kita akan fokus ke bagian textfield pada bagian [view](./view/search_part_view.dart) di bagian ini pada bagian textfield maka akan dimasukan logika ketika ada perubahan/onchange pada bagian ini.
```dart
 AppBar(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        controller: controller.textSearch,
        decoration: const InputDecoration(
          hintText: "Search Here",
          border: InputBorder.none,
          labelStyle: TextStyle(
            color: Colors.blueGrey,
          ),
          disabledBorder: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
            ),
          ),
        ),
        onChanged: (value) {
          //jadi ketika ada perubahan maka akan trigger ke fungction serach data, kenapa value nya tidak di ambil karna textfield ini sudah di set ke textfieldController
          controller.serchData();
        },
        onSaved: (newValue) {},
      ),
    ),
    actions: const [],
  ),
``` 
- selanjutnya perubahan akan di tangkap pada function serchData() pada textfield di bagian [controller](./controller/search_part_controller.dart), di bagian ini akan ada beberapa logika yang akan dijalankan sebagai berikut:
```dart
serchData() {
    //membuka dialog loading
    Get.showOverlay(
        loadingWidget: const QLoadingWidget(),
        asyncFunction: () async {
          //pada bagian ini akan membuat sebuah function untuk deconcer call, akan di set per 1 detik di bagian variable awal 
          debouncer.call(
            () {
              //kondisi pertama adalah ketika fieldName ini berisi "Part Number"
              if (fieldName == "Part Number") {
                debugPrint("kondisi location name");
                debugPrint("data field: $fieldName");
                //fungsi ini akan di load ketika kondisi pertama berjalan
                processSearchPart();
              } else {
                debugPrint("kondisi part name");
                debugPrint("data field: $fieldName");
                //fungsi ini akan di load ketika kondisi kedua berjalan
                processSearchLocation();
              }
            },
          );
        });
  }
```
- berikut ini merupakan penjelasan apa yang terjadi ketika kondisi pertama dan kondisi kedua berjalan
<br>

__kondisi pertama__
```dart
//kondisi pertama
  processSearchPart() async {
    //akan menjalankan function yang sudah di buat di supabase bernama searchpartnumber dengan beberapa parameter yang sudah di set pada bagian awal
    try {
      final data = await supabase.rpc('searchpartnumber', params: {
        "part_number_params": textSearch.text,
        "isminim": isMinim,
        "order_by_created_at": isAscending
      });
      //data akan dimasukan ke dalam list yang dibuat di bagian awal
      dataPart = List<Map<String, dynamic>>.from(data);
      update();
      log.i(dataPart);
    } catch (e) {
      //jika kondisi error
      debugPrint(e.toString());
    }
    //akan melakukan update pada UI
    update();
  }
```
<br>

__kondisi kedua__
```dart
//kondisi kedua
  processSearchLocation() async {
    try {
      //akan melakukan seleksi ke uspabse berdasrkan relasi dari tabel location dan select terhubung ke transaksi dan part, yang miliki quantity 0 berdasarkan head_name sama seperti pada bagian textfield dan di order berdarkan created_at dan ascending
      
      var data = await supabase
          .from("location")
          .select(
            "*, transaction(*, part(*))",
          )
          .eq("quantity", 0)
          .like("head_name", "%${textSearch.text}%")
          .order("created_at", ascending: isAscending);
      log.f(data);
      //set ke dalam list dataLoaction
      dataLocation = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      //print ketika error
      debugPrint(e.toString());
    }
    //update UI
    update();
  }
```

