import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final String labelText;
  final TextInputType keyboardtype;

  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.prefixIcon,
      required this.keyboardtype,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        textCapitalization: TextCapitalization.words,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardtype,
        cursorColor: Colors.blue[800],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '* Field is Empty';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
