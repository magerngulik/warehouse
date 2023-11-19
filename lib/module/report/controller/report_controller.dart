import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/report_view.dart';

class ReportController extends GetxController {
  ReportView? view;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllData();
  }

  var allData = [];
  var log = Logger();

  doDownloadExcel() async {
    var excel = Excel.createExcel();
    excel.rename(excel.getDefaultSheet()!, "Test Sheet");

    var sheet = excel["Test Sheet"];

    var cell =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));

    cell.value = "Index ke A1";

    var cell2 = sheet.cell(CellIndex.indexByString("A2"));
    cell2.value = "index ke A2";

    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

// File(join('$directory/output_file_name.xlsx'))
//   ..createSync(recursive: true)
//   ..writeAsBytesSync(fileBytes);
  }

  testExport() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['SheetName'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 'Hello Flutter';
    cell.cellStyle = cellStyle;

    var currentDate = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    try {
      var fileBytes = excel.save();
      var downloadDirectory =
          Directory('/storage/emulated/0/Download/Warehouse');

      if (!downloadDirectory.existsSync()) {
        downloadDirectory.createSync(recursive: true);
      }

      var newFileName = 'laporan_data_$formattedDate.xlsx';
      var outputFile = File('${downloadDirectory.path}/$newFileName');
      outputFile.writeAsBytesSync(fileBytes!);

      if (outputFile.existsSync()) {
        log.d('File successfully saved at: ${outputFile.path}');
        Get.dialog(
            QDialog(message: "Data berhasil di simpan, di ${outputFile.path}"));
      } else {
        log.d('Error saving the file.');
      }
    } catch (e) {
      log.e('Error: $e');
    }
  }

  testGenerate() {
    // Add header row
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['dataReport'];

    // Add header row with styling
    sheetObject.appendRow(
      ["PART NUMBER", "PART NAME", "QUANTITY", "LOCATION", "TIMESTAMP", "USER"],
    );
    sheetObject.cell(CellIndex.indexByString("A1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("B1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("C1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("D1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("E1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("F1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.setColumnWidth(0, 20.78);
    sheetObject.setColumnWidth(1, 45.67);
    sheetObject.setColumnWidth(2, 20.78);
    sheetObject.setColumnWidth(3, 20.78);
    sheetObject.setColumnWidth(4, 45.67);
    sheetObject.setColumnWidth(5, 45.67);

    // Add data rows with styling
    for (var data in allData) {
      String partNumber = data['transaction'].isNotEmpty
          ? data['transaction'][0]['part']['part_number']
          : '-';
      String partName = data['transaction'].isNotEmpty
          ? data['transaction'][0]['part']['part_name']
          : '-';
      int quantity = data['quantity'] ?? 0;
      String location = data['head_name'].toString();

      // Mengambil tanggal dari timestamp
      String fullTimestamp = data['updated_at'] ?? '-';
      String dateOnly = '-';

      if (fullTimestamp != '-') {
        DateTime dateTime = DateTime.parse(fullTimestamp);
        dateOnly =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      }

      String user = data['user']['username'] ?? '-';

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

    var currentDate = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    try {
      var fileBytes = excel.save();
      var downloadDirectory =
          Directory('/storage/emulated/0/Download/Warehouse');

      if (!downloadDirectory.existsSync()) {
        downloadDirectory.createSync(recursive: true);
      }

      var newFileName = 'laporan_data_$formattedDate.xlsx';
      var outputFile = File('${downloadDirectory.path}/$newFileName');
      outputFile.writeAsBytesSync(fileBytes!);

      if (outputFile.existsSync()) {
        log.d('File successfully saved at: ${outputFile.path}');
        Get.dialog(
            QDialog(message: "Data berhasil di simpan, di ${outputFile.path}"));
      } else {
        log.d('Error saving the file.');
      }
    } catch (e) {
      log.e('Error: $e');
    }
  }

  getAllData() async {
    try {
      final data = await supabase
          .from('location')
          .select('*,user(*),transaction(*,part(*))')
          .order('created_at', ascending: true);
      log.f(data);
      debugPrint(data.toString());
      allData = List.from(data);
    } catch (e) {
      Get.dialog(QDialog(message: "ada kesalahan $e"));

      debugPrint("$e");
    }
  }
}
