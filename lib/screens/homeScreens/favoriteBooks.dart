import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pdmapp/models/Book.dart';
import 'package:pdmapp/screens/main.dart';

class favoritesTab extends StatefulWidget {
  favoritesTab({Key? key}) : super(key: key);

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favoritesTab> {
  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 95, bottom: 90),
      color: CupertinoColors.darkBackgroundGray,
      child: FutureBuilder<List<Book>>(
        initialData: [],
        future: login("aa", "aa").then((value) {
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
              final List<Book> books = [
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
                Book(0, "Policarpio", "author", "date", "gender"),
              ];
              return ListView.builder(
                padding: EdgeInsets.all(6.0),
                itemBuilder: (context, index) {
                  final Book book = books[index];
                  return _BookItem(book);
                },
                itemCount: books.length,
              );
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GlassContainer(
        blur: 3,
        shadowStrength: 10,
        opacity: 0.2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(18, 32, 18, 18),
              child: Text("Titulo:" + book.name),
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Text("Autor:" + book.author),
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Text("Genero:" + book.gender),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 32),
              child: Text("Lanácmento:" + book.date),
            ),
          ],
        ),
      ),
    );
  }
}
