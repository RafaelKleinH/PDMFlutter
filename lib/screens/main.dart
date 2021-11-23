import 'package:flutter/cupertino.dart';
import 'package:pdmapp/components/textfield.dart';

void main() => runApp(MeuCupertinoApp());

class MeuCupertinoApp extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey.withOpacity(0),
          middle: const Text('Login'),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome"),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: bbtextfield(
                  false,
                  "Usuario",
                  usernameTextController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text("Senha"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: bbtextfield(
                  true,
                  "Senha",
                  passwordTextController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
