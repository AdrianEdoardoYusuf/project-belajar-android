import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/main.dart';
import 'package:notes_app_sqflite/providers/note_providers.dart';
import 'package:notes_app_sqflite/widgets/textfield_custom.dart';
import 'package:provider/provider.dart';

class DialogCustom {
  static dialogCreateNote({required TextEditingController title}) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
      context: navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: const Text("Masukan judul catatan"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Form(
            key: _formKey,
            child: TextFieldCustom.form(controller: title),
          ),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: primaryColor),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              'Batal',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: primaryColor),
            ),
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() == true) {
                context
                    .read<NotesProviders>()
                    .createNewNote(title: title.text, description: '');
                title.clear();
              }
            },
            color: primaryColor,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: primaryColor),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              'Buat Catatan',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
