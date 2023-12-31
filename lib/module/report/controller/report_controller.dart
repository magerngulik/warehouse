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
  bool isLoading = false;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getAllDataReport();
    getAllDataTransaction();
  }

  var allDataReport = [];
  var allDataTransaction = [];
  var log = Logger();

  generateReportData() {
    // Add header row
    isLoading = true;
    update();

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

    sheetObject.cell(CellIndex.indexByString("C1")).cellStyle = CellStyle(
        backgroundColorHex: "#70ad47", horizontalAlign: HorizontalAlign.Left);

    sheetObject.cell(CellIndex.indexByString("D1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("E1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("F1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.setColumnWidth(0, 45.67);
    sheetObject.setColumnWidth(1, 45.67);
    sheetObject.setColumnWidth(2, 20.78);
    sheetObject.setColumnWidth(3, 20.78);
    sheetObject.setColumnWidth(4, 45.67);
    sheetObject.setColumnWidth(5, 45.67);

    // Add data rows with styling
    for (var data in allDataReport) {
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

    isLoading = false;

    update();
  }

  generateTransactionData() {
    // Add header row
    isLoading = true;
    update();

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Data Transaction'];

    // Add header row with styling
    sheetObject.appendRow(
      [
        "PART NUMBER",
        "PART NAME",
        "DESCRIPTION",
        "LOCATION",
        "QUANTITY",
        "STOCK",
        "USER",
        "TIMESTAMP",
      ],
    );
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

    sheetObject.cell(CellIndex.indexByString("G1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.cell(CellIndex.indexByString("H1")).cellStyle =
        CellStyle(backgroundColorHex: "#70ad47");

    sheetObject.setColumnWidth(0, 45.67);
    sheetObject.setColumnWidth(1, 45.67);
    sheetObject.setColumnWidth(2, 20.78);
    sheetObject.setColumnWidth(3, 20.78);
    sheetObject.setColumnWidth(4, 45.67);
    sheetObject.setColumnWidth(5, 45.67);
    sheetObject.setColumnWidth(6, 45.67);
    sheetObject.setColumnWidth(7, 45.67);

    // Add data rows with styling
    for (var data in allDataTransaction) {
      String partNumber =
          data['part'].isNotEmpty ? data['part']['part_number'] : '-';
      String partName =
          data['part'].isNotEmpty ? data['part']['part_name'] : '-';
      String location =
          data['location'].isNotEmpty ? data['location']['head_name'] : '-';
      String quantity = data['quantity'].toString();
      String stock = data['stock'].toString();
      String description = data['description'].toString();

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
          description,
          location,
          quantity,
          stock,
          user,
          dateOnly, // Menggunakan tanggal saja
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

      var newFileName = 'laporan_transaksi_$formattedDate.xlsx';
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

    isLoading = false;
    update();
  }

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
}
