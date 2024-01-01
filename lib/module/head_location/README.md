# Halaman Head Location View
pada halaman ini akan menampilkan tabel head location di dalam tabel head_location ini akan memiliki beberapa fiture seperti add, edit dan delete, untuk tampilan nya sebagai berikut:
![head_location](/assets/image/menu_admin/head_locaation.png)
- fiture untuk get data di tabel
```dart

  @override
  void onInit() {
    super.onInit();
    //dipanggil data di awal
    getDataHead();
  }
  //list data
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;

  RxBool isLoading = true.obs;
  //fiture untuk get data
  Future getDataHead() async {
    try {
      final dataHead = await supabase
          .from('head_location')
          .select('*')
          .order("created_at", ascending: true);
      data.assignAll(List<Map<String, dynamic>>.from(dataHead));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
```
- fiture untuk delete data
```dart
 deleteHeadLocationData(int id) {
    //mengambil paramter id dari view
    //menampilkan confirm dialog
    Get.dialog(MDialogConfrmationDelete(
      onTap: () async {
        //menampilkan loading
        Get.showOverlay(
          loadingWidget: const Center(
            child: CircularProgressIndicator(),
          ),
          asyncFunction: () async {
            try {
            //fungsi supabase untuk delte data
              await supabase.from('head_location').delete().match({'id': id});
              getDataHead();
            } catch (e) {
              //menampilkan dialog error ketika proses gagal
              Get.dialog(MDialogFailed(message: e.toString()));
            }
          },
        );
      },
    ));
  }
```
- fiture untuk edit data, untuk edit sendiri akan mengarah ke [add_head_location](../add_head_location/README.md)


