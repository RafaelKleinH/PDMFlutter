import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdmapp/components/textfield.dart';
import 'package:pdmapp/screens/register.dart';

void main() => runApp(MeuCupertinoApp());

class MeuCupertinoApp extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: Builder(
        builder: (context) => CupertinoPageScaffold(
          backgroundColor: CupertinoColors.darkBackgroundGray,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0),
            middle: const Text(
              '',
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome",
                  style: TextStyle(
                    color: CupertinoColors.white.withAlpha(215),
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 56.0,
                    child: bbtextfield(
                      false,
                      "Usuario",
                      usernameTextController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Senha",
                    style: TextStyle(
                      color: CupertinoColors.white.withAlpha(215),
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 56.0,
                    child: bbtextfield(
                      true,
                      "Senha",
                      passwordTextController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    children: [
                      CupertinoButton(
                        child: Center(
                          child: Text("Entrar"),
                        ),
                        color: CupertinoColors.white.withAlpha(220),
                        onPressed: null,
                      ),
                      CupertinoButton(
                        child: Center(
                          child: Text(
                            "Registrar",
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => registerView()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
