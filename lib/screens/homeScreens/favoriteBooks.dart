import 'package:pdmapp/models/Book.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdmapp/components/textfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pdmapp/models/User.dart';
import '../main.dart';

class favoritesTab extends StatefulWidget {
  User user;
  favoritesTab(this.user);

  @override
  _favoritesState createState() => _favoritesState(user);
}

class _favoritesState extends State<favoritesTab> {
  final List<String> entries = <String>['A', 'B', 'C'];
  List<dynamic> books = [];
  User user;

  _favoritesState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 95, bottom: 90),
      color: CupertinoColors.darkBackgroundGray,
      child: FutureBuilder<List<Book>>(
        initialData: [],
        future:
            favoriteList(context, user.i_id_usuario.toString()).then((value) {
          books = value;
          return value;
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: CupertinoColors.white,
                    ),
                    Text(
                      'Loading',
                      style: TextStyle(color: CupertinoColors.white),
                    )
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (books.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.all(6.0),
                  itemBuilder: (context, index) {
                    final Book book = books[index];
                    return _BookItem(book);
                  },
                  itemCount: books.length,
                );
                break;
              } else {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Text(
                          'Não foi encontrado nenhum livro favorito, Tente Recarregar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CupertinoButton(
                          child: Text(
                            'Recarregar',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            setState(() {});
                          })
                    ],
                  ),
                );
              }
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}

class _BookItem extends StatelessWidget {
  final Book book;

  _BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white70,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 32, 18, 0),
                child: Text(
                  book.name! ?? "",
                  style: TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4, left: 18, right: 18),
                child: Text(
                  book.author ?? "",
                  style: TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Text(
                  book.gender ?? "",
                  style: TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 32),
                child: Text(
                  book.date! ?? "",
                  style: TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future favoriteList(context, String userId) async {
  final resposta = await http.post(
    Uri.parse(
        "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_listar_favorito.php"),
    body: {'id_usuario': userId},
  );

  if (resposta.statusCode == 200) {
    final data = jsonDecode(resposta.body);
    final List<Book> book = [];
    if (data != "nop") {
      for (Map i in data) {
        book.add(Book.fromJson(i));
      }
    }
    return book;
  }
}
