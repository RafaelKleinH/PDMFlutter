import 'package:pdmapp/models/Book.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdmapp/components/textfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class homeTab extends StatefulWidget {
  String name;

  homeTab(this.name);

  @override
  _homeTabState createState() => _homeTabState(name);
}

class _homeTabState extends State<homeTab> {
  String name;
  List<dynamic> books = [];
  _homeTabState(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 95, bottom: 90),
      color: CupertinoColors.darkBackgroundGray,
      child: FutureBuilder<List<Book>>(
        initialData: [],
        future: bookList(context).then((value) {
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
                    CircularProgressIndicator(),
                    Text('Loading')
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
              } else {
                return Center(
                  child: Text("Nenhum livro na lista"),
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

class _BookItem extends StatelessWidget {
  final Book book;

  _BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: ListTile(
        title: Text(
          book.name ?? "",
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          book.author.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

Future bookList(context) async {
  final resposta = await http.post(
    Uri.parse("http://200.19.1.18/20181GR.TII_I0084/flutter/livro_listar.php"),
    body: {'id_usuario': "0"},
  );

  if (resposta.statusCode == 200) {
    final data = jsonDecode(resposta.body);
    print(data);
    final List<Book> book = [];
    for (Map i in data) {
      book.add(Book.fromJson(i));
    }
    return book;
  }
}
