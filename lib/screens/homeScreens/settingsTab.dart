import 'package:flutter/cupertino.dart';

class SettingsTab extends StatelessWidget {
  String name;

  SettingsTab(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      color: CupertinoColors.darkBackgroundGray,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, left: 18, right: 18),
            child: Text(
              "Olá $name bem vindo ao E-Book ✋",
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w100,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 42.0, right: 18, left: 18),
            child: Column(
              children: [
                CupertinoButton(
                  child: Center(
                    child: Text("Sair"),
                  ),
                  color: CupertinoColors.white.withAlpha(8),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
