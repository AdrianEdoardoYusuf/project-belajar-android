import 'package:flutter/material.dart';

class ContentNoteBasic extends StatelessWidget {
  final String id;
  final String desc;
  final TextEditingController controller;
  const ContentNoteBasic(
      {Key? key,
      required this.id,
      required this.controller,
      required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = desc;
    return TextFormField(
      controller: controller,
      autofocus: true,
      maxLines: null,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
