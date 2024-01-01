# Halaman Register User
pada halaman ini berfungsi untuk melakukan register ke user baru,untuk penjelasan nya sebagai berikut 
- melakukan definisi ke textfield dan textfield controller di bagian [controller](./controller/register_user_controller.dart)
```dart 
  //berikut ini beberapa variable yang akan dimasukan ketika register, utnuk isLoading dan errorText berfungsi untuk indikator error pada halaman dan string error text
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPsController = TextEditingController();
  var jobLevel = TextEditingController();
  var positon = TextEditingController();
  var isLoading = false;
  String errorText = "";
``` 

- selanjutnya adalah function untuk melakukan register sebagai berikut
```dart
doRegister() async {
  //bagian ini merupakan validasi untuk textfield yang ada
    if (nameController.text == "") {
      errorText = "username tidak boleh kosong";
    } else if (emailController.text == "") {
      errorText = "email tidak boleh kosong";
    } else if (passwordController.text == "") {
      errorText = "password tidak boleh kosong";
    } else if (confirmPsController.text == "") {
      errorText = "confirm password tidak boleh kosong";
    } else if (jobLevel.text == "") {
      errorText = "job level harus di pilih";
    } else if (positon.text == "") {
      errorText = "posisi harus di pilih";
    } else if (confirmPsController.text != passwordController.text) {
      errorText = "password tidak sama";
    }
    //cek ketika ada error yang terjadi dalam validasi 
    if (errorText != "") {
      Get.dialog(QDialog(
        message: errorText,
      ));
      errorText = "";
      update();
      //jikan kondisi terpenuhi akan menampilkan dialog error
      return;
    } else {
      isLoading = true;
      // jika tidak ada error makan loading akan di munculkan dan update UI
      update();
      //di bagian ini akan menambahkan user, dan bagian ini akan mendaftarkan user dan parameter yang dimasukan berupa email dan password
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      //setelah user di buat maka kita mendapatkan variable hasil dari user yang sudah didapatkan.
      final User? user = res.user;
      //selanjutkan akan cek status dari user yang mendaftar 
      if (user != null) {
        //jika user tidak kosong yang bearti status benar
        try {
        //maka akan menampahkan atau mengantikan beberapa parameter pada tabel user
          await supabase.from('user').upsert([
            {
              'id': user.id,
              'email': user.email,
              'username': nameController.text,
              'position': positon.text,
              'job_level': jobLevel.text,
            },
          ]);
          //jika proses penambahan user berhasi bakan akan ditampilkan dialog succes
          Get.dialog(QDialog(
            message: "Berhasil daftar silahkan login",
            ontap: () {
              adminManageUserController.getDataUser();
              Get.back();
              Get.back();
            },
          ));
        } catch (e) {
          //menampilkan dialog jika kondisi gagal
          Get.dialog(QDialog(message: "Gagal Register - Error: $e"));
        }
      }
    }
    //menutup kondisi loading
    isLoading = false;
    //update tampian untuk mematikan kondisi dari ui nya
    update();
  }
```