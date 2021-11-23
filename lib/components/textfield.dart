import 'package:flutter/cupertino.dart';

class bbtextfield extends StatelessWidget {
  final bool isPassword;

  bbtextfield(this.isPassword);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      autocorrect: false,
    );
  }
}
