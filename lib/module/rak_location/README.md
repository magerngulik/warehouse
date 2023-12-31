# Halaman Rak Location
pada halaman ini akan mengambil data yang di kirim lewat paramter dari halaman sebelumnya di sini kita ambil dulu data yang di kirim dari paramenter view ke dalam parameter di controller, untuk kode nya di bagian ini:

data dari view:

``` dart
class RakLocationView extends StatelessWidget {
  //variable data di dapat pada halaman sebelumnya
  final Map data;
  const RakLocationView({
    Key? key,
    required this.data,
  }) : super(key: key);
override
  Widget build(BuildContext context) {
    return GetBuilder<RakLocationController>(
    //variable ini akan di teruskan di controller
      init: RakLocationController(data: data),
      builder: (controller) {
        controller.view = this;
```

tujuan dari di kirimnya data ini adalah untuk mendapatkan nilai dari location_name yang ada pada Map data, 

untuk di controller akan diambil seperti ini:
```dart
RakLocationController({this.data});
 
```
selanjutnya tujuan nya adalah untuk mendapatkan location name, idHead, maxLantai dan maxRak
```dart
//pertama akan set locationName
String locationName="";
int idHead = 0;
int maxRak = 0;
int maxLantai = 0;
String headTag = "";
```

selanjutnya akan di set di oninit seperti ini:
```dart
 @override
  void onInit() {
    super.onInit();
    //set location name dari data yang dikirim di parameter
    locationName = data!['location_name'];
    //set idHead dari data yang dikirim di parameter
    idHead = data!['id'];
    //set maxLantai dari data yang dikirim di parameter
    maxLantai = data!['max_lantai'];
    //set maxRak dari data yang dikirim di parameter
    maxRak = data!['max_rak'];
    //membuat location name untuk di tampilkan di view
    var list = locationName.split('-'); // memisahkan string berdasarkan tanda hubung
    //mendapat head name
    headTag = list[0];
    getDataLocation();
    refreshAftarBuild();
  }
```
dalam oninit ada 2 fungtion **getDataLocation** dan **refreshAfterBuild**, getDataLocation berfungsi untuk mengambi data lokasi, berdasarkan idHead yang sudah di ambil sebelumnya kemudian di set ke dalam **listData** sebelumnya, refreshAfterBuild berfungsi untuk merefresh setelah satu detik setelah widget di build, ini dilakukan bukan tanpa alaman karna pada saat on init tidak bisa melakukan update pada ui sehingga harus di tunggu beberapa saat agar tidak terjadi crash saat widget awal di load

untuk penjelasan dari 2 fungsi di atas adalah sebagai berikut:
```dart
getDataLocation() async {
    //buka loading pada view
    isLoading = true;
    try {
      //koding dari supabase untuk get data berdasrkan head_location_id  
      var data = await supabase
          .from("location")
          .select("*,transaction(*,part(*))")
          .eq("head_location_id", idHead)
          .order("created_at", ascending: true);
      //memasukan data yang di ambil ke dalam listData
      listData = RxList<Map<String, dynamic>>.from(data);
      //mematikan loading
      isLoading = false;
      //update view
      update();
      log.d(listData);
    } catch (e) {
      //ketika terjadi error makan loading juga di matikan
      isLoading = false;
      update();
      //ketika gagal di tampilkan dialog
      Get.dialog(QDialog(message: "Terjadi error pada server: $e"));
    }
  }
```
```dart

  refreshAftarBuild() async {
    //tunggu 1 detik 
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("di refresh");
    //update tampilan
    update();
  }
```
