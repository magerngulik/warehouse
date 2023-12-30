# Halaman Login
untuk logika di halaman ini akan di mulai dari membuat 2 buah textediting controller, untuk menampung email dan password pada bagian ini:
```dart
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
```

langkah selanjutnya akan di mulai dari fungtion doLogin, langkah pertama di doLogin akan check apakah email ynag ada ini valid atau tidak di menggunakan fungtion ini, dengan hasil akhir bool, yang akan membalikan nilai true dan false
``` dart
  var isExist = await checkUserExist(textEmail.text);

  //isi dari fungsi nya
   Future<bool> checkUserExist(String email) async {
    var response = await supabase.from('user').select("*").eq('email', email);
    debugPrint("data response: $response");

    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
```

Jika balikan dari __isExist__ itu true akan di arakan ke proses login, jika tidak maka koding akan di return, selanjutnya akan menampikan loading dialog seperti dan menjalankan logic nya.
```dart

if (isExist) {
    //Bagian ini akan menampilkan overlay loading
      Get.showOverlay(
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        asyncFunction: () async {
        //bagian ini akan menampilakan fungsi secara asyncoronus
        //fungsi try di sini akan di gunakan untuk menangkap error yang ada dan mendapatkan pesan nya
      
          try {
            //bagian ini merupakan fungsi bawaan dari supabase untuk check signin
            // fungsi ini akan memerlukan email dan password yang sudah di buat sebelum nya
            await supabase.auth.signInWithPassword(
                password: textPassword.text, email: textEmail.text);
            // bagian ini merupakan bagian untuk mengambil id user
            final user = supabase.auth.currentUser!.id;
            //di sini akan check tabel user berdasarkan id yang sudah di dapatkan diatas
            final profile =
                await supabase.from('user').select('*').eq('id', user);
            //setelah di dapatkan akan mengambil index pertama [0], dan memasukan ke variable di bawah ini    
            var uuid = profile[0]['id'];
            var email = profile[0]['email'];
            var username = profile[0]['username'];
            var role = profile[0]['role'];
            var status = profile[0]['status'];
            var jobLevel = profile[0]['job_level'];
            var position = profile[0]['position'];
            //setelah di dapatkana makan akan di save dilocal agar tidak di panggil pada setiap screens

            saveToLocal(
                uuid: uuid,
                email: email,
                username: username,
                role: role,
                jobLevel: jobLevel,
                position: position);
            //variable status ini berisi nilai iya dan tidak, jika tidak makan akan di kembalikan dan tidak bisa lanjut ke halaman selanjutnya, karna user ini sudah di block    
            if (status == "tidak") {
              Get.dialog(const QDialog(
                  message:
                      "Akun anda telah di ban oleh admin, gunakan akun lain untuk menggunakan aplikasi ini"));
              return;
            }
            //pada bagian ini akan dibuatkan percabangan untuk role admin dan user biasa jika pada variable role nilai nya admin di arahkan ke halaman admin, jika tidak maka akan di arahkan ke halaman user

            if (role == "admin") {
              Get.offAll(const AdminMenuView());
            } else {
              Get.offAll(const DashboardView());
            }
          } catch (e) {
            //disini adalah perintah jika pada try tadi terdapat error makan akan di tampikan error, karna salah nya pada email dan password
            debugPrint(e.toString());
            Get.dialog(const QDialog(
                message:
                    "Gagal Login coba check email dan password dengan benar"));
          }
        },
      );
    }
    ```