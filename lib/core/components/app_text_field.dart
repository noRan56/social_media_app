import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final int? maxLine;
  final bool obsecureText;
  final TextEditingController controller;
  const AppTextField(
      {super.key,
      this.maxLine,
      required this.hintText,
      required this.obsecureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      maxLines: maxLine,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0)),
          hintText: hintText),
    );
  }
}
