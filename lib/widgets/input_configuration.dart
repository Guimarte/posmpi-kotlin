import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputConfiguration extends StatelessWidget {
  InputConfiguration(
      {required this.controller,
      required this.hint,
      required this.label,
      required this.textInputType});
  TextEditingController controller = TextEditingController();

  String label = '';
  String hint = '';
  TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CnpjInputFormatter(),
        ],
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF001848)),
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF001848)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color(0xFF001848),
            ),
          ),
        ),
      ),
    );
  }
}
