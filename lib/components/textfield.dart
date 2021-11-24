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
    return CupertinoTextField.borderless(
      autocorrect: false,
      obscureText: isPassword,
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        color: CupertinoColors.white.withAlpha(150),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupertinoColors.white.withAlpha(
            150,
          ),
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      controller: controller,
      style: TextStyle(
        fontSize: 22.0,
        height: 1.0,
        color: CupertinoColors.white,
      ),
    );
  }
}
