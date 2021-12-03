// ignore: file_names
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdmapp/components/textfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class createBookTab extends StatefulWidget {
  createBookTab({Key? key}) : super(key: key);

  @override
  _createBookTabState createState() => _createBookTabState();
}

class _createBookTabState extends State<createBookTab> {
  final bookNameTextController = TextEditingController();
  final bookGenderTextController = TextEditingController();
  final bookAuthorTextController = TextEditingController();
  final bookYearTextController = TextEditingController();
  DateTime? _chosenDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.darkBackgroundGray,
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 72),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nome do Livro",
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
                    "Nome",
                    bookNameTextController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Autor",
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
                    false,
                    "Nome do Autor",
                    bookAuthorTextController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Ano de lançamento",
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
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) {
                        if (focus) {
                          print(focus);
                          _showDatePicker(context);
                        }
                      },
                      child: bbtextfield(
                        false,
                        "14/12/2002",
                        bookYearTextController,
                        enabled: true,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Genero do livro",
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
                    false,
                    "Romance não",
                    bookGenderTextController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    CupertinoButton(
                      child: Center(
                        child: Text("Publicar Livro"),
                      ),
                      color: CupertinoColors.white.withAlpha(8),
                      onPressed: () {
                        bool isTextCorrect = isTextCorrectNotNull();

                        String? alertText = isTextCorrect
                            ? null
                            : "Todos campos devem estar preenchidos";
                        debugPrint(alertText.toString());

                        if (alertText == null) {
                          if (_chosenDateTime != null) {
                            print(_chosenDateTime!);
                            registerBook(
                                context,
                                bookNameTextController.text,
                                bookAuthorTextController.text,
                                bookGenderTextController.text,
                                bookYearTextController.text,
                                "0");
                          }
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
                                  onPressed: () => Navigator.pop(context, "OK"),
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
    );
  }

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 300,
        color: Color.fromARGB(255, 255, 255, 255),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              Container(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (val) {
                    setState(() {
                      _chosenDateTime = val;
                      final formatter = new DateFormat('dd/MM/yyyy');
                      bookYearTextController.text = formatter.format(val);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isTextCorrectNotNull() {
    return bookNameTextController.text.isNotEmpty &&
        bookAuthorTextController.text.isNotEmpty &&
        bookGenderTextController.text.isNotEmpty &&
        bookYearTextController.text.isNotEmpty;
  }
}

Future registerBook(context, String bookName, String bookAuthor,
    String bookGender, String bookYear, String userId) async {
  final resposta = await http.post(
    Uri.parse(
        "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_cadastrar.php"),
    body: {
      "nome_livro": bookName,
      "autor_livro": bookAuthor,
      "data_livro": bookYear,
      "genero_livro": bookGender,
      "id_usuario": userId,
    },
  );
  var response = resposta.statusCode;
  print(bookName);
  print(bookAuthor);
  print(bookYear);
  print(bookGender);
  print(userId);
  print(response);
  if (response == 200 || response == 201) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Foi!"),
        content: const Text("Livro criado"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context, "OK"),
          )
        ],
      ),
    );
  } else {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Opss!"),
        content: const Text("Senha incorreta"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context, "OK"),
          )
        ],
      ),
    );
  }
}
