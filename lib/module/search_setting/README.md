# Halaman Search Setting
halaman ini adalah setting pada halaman search, fungsi utama disini adalah untuk save fungsi dan apa saja yang ingin dimasukan pada bagian search field
```dart
@override
  void onInit() {
    super.onInit();
    //load jika ada data setting sebelum ini
    getLoadSetting();
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("List Search");
  }

  SearchSettingView? view;
  //list untuk selection pada menu view
  List<String> dataSearch = ["Part Number", "Ruang Kosong"];
  //defaukt serach field
  String searchField = "Part Number";
  //cek apakah ascending atau tidak
  bool isAcending = true;

  //cek apakah minim atau tidak
  bool isMinim = true;

  doSaveSetting() async {
  //save setting dan simpan ke local storage
    var prefh = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefh);
    local.saveString("searchField", searchField);
    local.saveBool("isAcending", isAcending);
    local.saveBool("isMinim", isMinim);
    update();
    Get.back();
  }

  getLoadSetting() async {
    //load setting untuk cek kondisi awal pada data
    var prefh = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefh);
    searchField = local.getString("searchField");
    isAcending = local.getBool("isAcending");
    isMinim = local.getBool("isMinim");
    update();
  }

  doPrintData() {
    debugPrint("search field = $searchField");
    debugPrint("is ascanding = $isAcending");
  }
```