# Halaman Login
pada awal halaman ini akan menjalankan beberapa fungsi seperti ini:
```dart
  //on init akan berjalan di awal
  @override
  void onInit() {
    deleyProcess();
    getJobLevel();
    super.onInit();
  }
```
ada 2 fungsi yang akan di jalan kan yaitu __delayProcess()__ dan __getJobLevel()__ yang fungsi nya sebagai berikut:

```dart
//disini fungsi nya di dwlay 3 detik, fungsi di deley ini karna di on init ini harus menunggu page nya di buat terlebih dahulu, kemudia di get user
 deleyProcess() async {
    Future.delayed(const Duration(seconds: 3));
    await getuser();
  }
  //get user sendiri akan mengambil username dan email dari supabase
  getuser() async {
    try {
      //merupakan fungsi dari supabase ketika sudah login
      userId = supabase.auth.currentUser!.id;
      debugPrint("userid : $userId");
      //merupakan fungsi untuk seleksi data dari supabase
      final data =
          await supabase.from('user').select("*").eq('id', userId).single();
      //username dan email dari data yang di get dari supabse
      username = data['username'] ?? '';
      email = data['email'] ?? '';
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //job level didapatkan dari local storage yang sudah kita set ketika login
  getJobLevel() async {
    var preft = await SharedPreferences.getInstance();
    var dataLocal = SharedPreferencesService(preft);
    jobLevel = dataLocal.getString("job_level");
    position = dataLocal.getString("position");
  }

```
ada beberapa fungsi yang di letakan pada untuk menampilkan dialog yang mengandung informasi jari __jobLevel__ dan __position__ di atas kode untuk menampilkan dialog sebagai berikut:
```dart
  openDialogPosition() {
    Get.dialog(QDialog(message: "Posisi anda saat ini adalah $position"));
  }

  openDialogJobLevel() {
    Get.dialog(QDialog(message: "Job Level anda saat ini adalah $jobLevel"));
  }
```
untuk pemangilan ini di hubungkan pada view di bagian ini:
```dart
   ListTile(
      leading: const Icon(Icons.leaderboard_outlined),
      title: const Text("Job Level "),
      onTap: () => controller.openDialogJobLevel(),
    ),
    ListTile(
      leading: const Icon(Icons.badge),
      title: const Text("Position"),
      onTap: () => controller.openDialogPosition(),
    ),
```

selanjutnya ada juga kode untuk logout dan mereset status login dari supabase seperti berikut ini:
```dart
//fungsi dari logout
 doLogout() async {
    var data = await AuthServices.logout();

    if (data) {
      Get.offAll(const LoginView());
    } else {
      Get.dialog(QDialog(message: AuthServices.errorLogout));
    }
  }

//kode untuk open dialog
  openDialogLogout() {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        Get.dialog(QDialogLogout(
          message: "apakah anda yakin ingin keluar?",
          ontap: () {
            doLogout();
          },
        ));
      },
    );
  }

 // pada bagian view di hubungkan di bagian ini:
ListTile(
  leading: const Icon(
    Icons.logout,
  ),
  title: const Text("Logout"),
  onTap: () => controller.openDialogLogout(),
)
```

Dashbord sendiri akan menampilkan 2 menu dan menentukan pilihan kemana menu yang akan tujuan user, seperti berikut:
```dart
 var menu = [
    {"menu": "List Part Area F", "onclick": const ListPartView()},
    {"menu": "Report", "onclick": const ReportView()}
  ];
```
sementara untuk menu yang di tampikan akan di filter, akan menampilkan menu report jika position nya adalah __Leader__ seperti ini pada bagian view:
```dart
 controller.jobLevel == "Leader"
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            Get.to(const ReportView());
                          },
                          child: const Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Report",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
```