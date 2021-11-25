import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdmapp/components/textfield.dart';
import 'package:pdmapp/screens/register.dart';

import 'home.dart';

void main() => runApp(MeuCupertinoApp());

class MeuCupertinoApp extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? alertText;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      title: 'Cupertino App',
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => CupertinoPageScaffold(
          backgroundColor: CupertinoColors.darkBackgroundGray,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0),
            middle: const Text(
              '',
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            alignment: Alignment.center,
            child: SingleChildScrollView(
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
                          color: CupertinoColors.white.withAlpha(8),
                          onPressed: () {
                            bool isTextCorrect = isTextCorrectNotNull();

                            alertText = isTextCorrect
                                ? null
                                : "Todos campos devem estar preenchidos";
                            debugPrint(alertText.toString());

                            if (alertText == null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => homeView(),
                                ),
                              );
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
      ),
    );
  }

  bool isTextCorrectNotNull() {
    return usernameTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty;
  }
}
