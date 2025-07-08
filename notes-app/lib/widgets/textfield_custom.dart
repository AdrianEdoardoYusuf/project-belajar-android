import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';

class TextFieldCustom {
  static TextFormField form({required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Form ini tidak boleh kosong *";
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
