// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/color/m_base_color.dart';

class QMyDropdown2 extends StatefulWidget {
  final List<String> data;
  final Function(String value) onChanged;
  final String? firstData;
  final String? hintText;
  final String title;

  const QMyDropdown2(
      {Key? key,
      required this.data,
      required this.onChanged,
      this.firstData,
      required this.title,
      this.hintText})
      : super(key: key);

  @override
  _QMyDropdown2State createState() => _QMyDropdown2State();
}

class _QMyDropdown2State extends State<QMyDropdown2> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.firstData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        decoration: InputDecoration(
          fillColor: textfieldColor,
          filled: true,
          hintText: widget.hintText ?? "Silahkah Pilih",
          errorStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(width: 2.0, color: textfieldColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(width: 2.0, color: textfieldColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(width: 2.0, color: textfieldColor),
          ),
        ),
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        items: widget.data.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          widget.onChanged(value!);
        },
      ),
    );
  }
}
