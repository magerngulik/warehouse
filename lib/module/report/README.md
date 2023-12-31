# Halaman Report
pada halaman ini akan fokus untuk menampilakn report, di awal akan di buat 2 variable sebagai berikut:
```dart
  var allDataReport = [];
  var allDataTransaction = [];
```
fungsi dari 2 variable di atas adalah untuk menampung hasil dari load data ke supabase, untuk fungsi nya akan di load dalam oninit, yang akan berjalan ketika program di jalankan, ada 2 fungsi yang akan di jalankan sebagai berikut:
```dart
//untuk get data all report
 getAllDataReport() async {
    try {
      final data = await supabase
          .from('location')
          .select('*,user(*),transaction(*,part(*))')
          .order('head_location_id', ascending: true);
      // log.f(data);
      // debugPrint(data.toString());
      allDataReport = List.from(data);
    } catch (e) {
      Get.dialog(QDialog(message: "ada kesalahan $e"));
      debugPrint("$e");
    }
  }
  //get data all history
  getAllDataTransaction() async {
    try {
      final data = await supabase
          .from('history')
          .select('*,part(*),location(*),user(*)')
          .order('created_at', ascending: true);
      log.f(data);
      // debugPrint(data.toString());
      allDataTransaction = List.from(data);
    } catch (e) {
      Get.dialog(QDialog(message: "ada kesalahan $e"));
      debugPrint("$e");
    }
  }
// kedua fungsi di atas akan di jalankan dalam onIntit seperti berikut ini:
  @override
  void onInit() {
    super.onInit();
    getAllDataReport();
    getAllDataTransaction();
  }
```

selain itu ada 2 fungsi lain nya yang akan menampilkan file excel di bagain ini, yaitu fungsi generateReportData() dan generateTransactionData() kedua fungsi ini akan mengenerate file excel nya, saya akan mencontohkan 1 saja karna dasar nya fungsi kedua ini sama, untuk memahami nya pada dasarnya anda harus membayangkan cell pada excel, untuk penjelasan sebagai berikut:
```dart
 generateReportData() {
    //menampilkan loading
    isLoading = true;
    update();
    //generate variable dari extensi excel
    var excel = Excel.createExcel();
    //membuat sheet baru
    Sheet sheetObject = excel['dataReport'];
    

    //membuat row untuk bagian header pada bagian tabel
    sheetObject.appendRow(
      ["PART NUMBER", "PART NAME", "QUANTITY", "LOCATION", "TIMESTAMP", "USER"],
    );
    //memberi styling pada cell berdasarkan nama cell nya
    sheetObject.cell(CellIndex.indexByString("A1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("B1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("C1")).cellStyle = CellStyle(
        backgroundColorHex: "#70ad47", horizontalAlign: HorizontalAlign.Left);

    sheetObject.cell(CellIndex.indexByString("D1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("E1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("F1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    //menambahkan ukuran pada cell, jadi 0 itu berada di column petama atau A1 dan seterusnya
    sheetObject.setColumnWidth(0, 45.67);
    sheetObject.setColumnWidth(1, 45.67);
    sheetObject.setColumnWidth(2, 20.78);
    sheetObject.setColumnWidth(3, 20.78);
    sheetObject.setColumnWidth(4, 45.67);
    sheetObject.setColumnWidth(5, 45.67);

    ///di bagian ini akan looping data nya dari data yang kita get di awal, dan memasukan nya ke dalam beberapa variable
    for (var data in allDataReport) {
      //menyimpan data part number
      String partNumber = data['transaction'].isNotEmpty
          ? data['transaction'][0]['part']['part_number']
          : '-';
      //menyimpan data part name
      String partName = data['transaction'].isNotEmpty
          ? data['transaction'][0]['part']['part_name']
          : '-';
      //menyimpan data quantity
      int quantity = data['quantity'] ?? 0;
      //menyimpan data head_name
      String location = data['head_name'].toString();

      // Mengambil tanggal dari timestamp
      //menyimpan data fullTimeStamo
      String fullTimestamp = data['updated_at'] ?? '-';
      //menyimpan data date
      String dateOnly = '-';

      if (fullTimestamp != '-') {
        DateTime dateTime = DateTime.parse(fullTimestamp);
        dateOnly =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      }

      //menyimpan data user
      String user = data['user']['username'] ?? '-';
      //data dari variable di atas akan di masukan ke row di bawah row head, sesuai dengan looping yang ada
      sheetObject.appendRow(
        [
          partNumber,
          partName,
          quantity,
          location,
          dateOnly, // Menggunakan tanggal saja
          user,
        ],
      );
    }
    //pada bagian ini akan membuatformat dari file yang akan di simpan ke device
    //buat format tanggal pada file
    var currentDate = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    //memulai proses save file
    try {
      //inisialisasi save file
      var fileBytes = excel.save();
      //directory dimana file di simpan
      var downloadDirectory =
          Directory('/storage/emulated/0/Download/Warehouse');

      //cek apakan directory nya ada atau tidak
      if (!downloadDirectory.existsSync()) {
        downloadDirectory.createSync(recursive: true);
      }
      //memberi naam dari formated date
      var newFileName = 'laporan_data_$formattedDate.xlsx';
      //menyiapkan output file   
      var outputFile = File('${downloadDirectory.path}/$newFileName');
      //menuliskan output file
      outputFile.writeAsBytesSync(fileBytes!);
      //cek jika output file sudah ada pada directory yang di tentukan
      if (outputFile.existsSync()) {
        //kondisi ketika berhasil
        log.d('File successfully saved at: ${outputFile.path}');
        //menampilkan dialog
        Get.dialog(
            QDialog(message: "Data berhasil di simpan, di ${outputFile.path}"));
      } else {
        //gagal ketika proses penyimpanan
        log.d('Error saving the file.');
      }
    } catch (e) {
      //gagal ketika proses tidak di ketahui
      log.e('Error: $e');
    }

    isLoading = false;

    update();
  }
```