import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdmapp/components/textField.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class registerView extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  String? alertText;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context, false),
          color: CupertinoColors.white,
        ),
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0),
        middle: const Text(
          '',
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
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
                  padding: const EdgeInsets.only(top: 14.0),
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
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Text(
                    "Confirmar Senha",
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
                      "Confirmar Senha",
                      confirmPasswordTextController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    children: [
                      CupertinoButton(
                        child: Center(child: Text("Registrar")),
                        color: CupertinoColors.white.withAlpha(8),
                        onPressed: () {
                          bool isTextCorrect = isTextCorrectNotNull();
                          bool isPasswordEqual = isPasswordsEquals();

                          alertText = isTextCorrect
                              ? null
                              : "Todos campos devem estar preenchidos";
                          debugPrint(alertText.toString());
                          if (alertText == null) {
                            alertText = isPasswordEqual
                                ? null
                                : "Senhas devem ser iguais.";
                          }
                          if (alertText == null) {
                            cadastrar(usernameTextController.text,passwordTextController.text);//TO DO POST...
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: Text("Opss!"),
                                content: Text(alertText!),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () =>
                                        Navigator.pop(context, "OK"),
                                  )
                                ],
                              ),
                            );
                          }
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

  bool isTextCorrectNotNull() {
    return usernameTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        confirmPasswordTextController.text.isNotEmpty;
  }

  bool isPasswordsEquals() {
    return passwordTextController.text == confirmPasswordTextController.text;
  }
}

Future cadastrar(usuario,senha) async {
  final resposta = await http.post(
    Uri.parse("http://200.19.1.18/20181GR.TII_I0084/flutter/inse_login.php"),
    body:{
     "usuario": usuario,
     "senha": senha,
    },
    );
  debugPrint(resposta.body);
}