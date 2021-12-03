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
        future: login(context, "aa", "aa").then((value) {
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
              final List<Book> books = [];
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
      child: Card(
        color: Colors.white70,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 32, 18, 0),
                child: Text(
                  book.name!,
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
                  book.author!,
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
                  book.gender!,
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
                  book.date!,
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
