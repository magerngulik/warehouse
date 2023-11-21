// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QMyDropdown extends StatefulWidget {
  final List<String> data;
  final Function(String value) onChanged;
  final String? firstData;

  const QMyDropdown(
      {Key? key, required this.data, required this.onChanged, this.firstData})
      : super(key: key);

  @override
  _QMyDropdownState createState() => _QMyDropdownState();
}

class _QMyDropdownState extends State<QMyDropdown> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.firstData ?? widget.data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Select Role",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
          DropdownButton<String>(
            borderRadius: BorderRadius.circular(12),
            value: selectedRole,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              selectedRole = value;
              widget.onChanged(selectedRole!);
              setState(() {});
            },
            items: widget.data.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
