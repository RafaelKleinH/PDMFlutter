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

class homeTab extends StatefulWidget {
  User user;

  homeTab(this.user);

  @override
  _homeTabState createState() => _homeTabState(user);
}

class _homeTabState extends State<homeTab> {
  User user;
  List<dynamic> books = [];
  _homeTabState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 95, bottom: 90),
      color: CupertinoColors.darkBackgroundGray,
      child: FutureBuilder<List<Book>>(
        initialData: [],
        future: bookList(context, user.i_id_usuario.toString()).then((value) {
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
                    return BookItem(book);
                  },
                  itemCount: books.length,
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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

              break;
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}

class BookItem extends StatefulWidget {
  Book book;

  BookItem(this.book);

  @override
  _BookItem createState() => _BookItem(book);
}

class _BookItem extends State<BookItem> {
  final Book book;

  _BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          turnFavorite(
                            context,
                            book.favorite ?? "",
                            book.id.toString(),
                          ).then(
                            (value) => {
                              if (value == "ok")
                                {
                                  book.favorite =
                                      book.favorite == "1" ? "0" : "1",
                                  setState(() {}),
                                }
                            },
                          );
                        },
                        color: CupertinoColors.systemYellow,
                        icon: book.favorite == "1"
                            ? Icon(CupertinoIcons.star_fill)
                            : Icon(CupertinoIcons.star),
                      ),
                      IconButton(
                        onPressed: () {
                          turnRead(
                            context,
                            book.read ?? "",
                            book.id.toString(),
                          ).then((value) => {
                                print('value:' + value),
                                if (value == "ok")
                                  {
                                    book.read = book.read == "1" ? "0" : "1",
                                    setState(() {}),
                                  },
                              });
                        },
                        color: book.read == "1"
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemRed,
                        icon: book.read == "1"
                            ? Icon(CupertinoIcons.check_mark_circled)
                            : Icon(CupertinoIcons.clear_circled),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 22, right: 18, left: 18),
                    child: Text(
                      book.name ?? "",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, right: 18, left: 18),
                    child: Text(
                      book.author ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, right: 18, left: 18),
                    child: Text(
                      book.gender ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, right: 18, left: 18, bottom: 22),
                    child: Text(
                      book.date ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future bookList(context, String userId) async {
  final resposta = await http.post(
    Uri.parse("http://200.19.1.18/20181GR.TII_I0084/flutter/livro_listar.php"),
    body: {'id_usuario': userId},
  );

  if (resposta.statusCode == 200) {
    final data = jsonDecode(resposta.body);
    // ignore: avoid_print
    print(data);
    final List<Book> book = [];
    if (data != "nop") {
      for (Map i in data) {
        book.add(Book.fromJson(i));
      }
    }
    return book;
  }
}

Future turnFavorite(context, String alreadyRead, String bookId) async {
  final resposta = await http.post(
    Uri.parse(alreadyRead != "1"
        ? "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_adicionar_favorito.php"
        : "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_remover_favorito.php"),
    body: {'id_livro': bookId},
  );

  if (resposta.statusCode == 200) {
    final data = jsonDecode(resposta.body);
    return data;
  }
}

Future turnRead(context, String alreadyRead, String bookId) async {
  final resposta = await http.post(
    Uri.parse(alreadyRead != "1"
        ? "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_adicionar_lido.php"
        : "http://200.19.1.18/20181GR.TII_I0084/flutter/livro_remover_lido.php"),
    body: {'id_livro': bookId},
  );

  if (resposta.statusCode == 200) {
    final data = jsonDecode(resposta.body);
    return data;
  }
}
