// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bbtextfield extends StatelessWidget {
  final bool isPassword;
  final String placeholder;
  final TextEditingController controller;

  bbtextfield(this.isPassword, this.placeholder, this.controller);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      autocorrect: false,
      obscureText: isPassword,
      placeholder: placeholder,
      controller: controller,
    );
  }
}
