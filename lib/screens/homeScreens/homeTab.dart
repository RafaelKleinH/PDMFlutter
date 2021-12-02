import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdmapp/models/Book.dart';

import '../main.dart';

class homeTab extends StatefulWidget {
  String name;

  homeTab(this.name);

  @override
  _homeTabState createState() => _homeTabState(name);
}

class _homeTabState extends State<homeTab> {
  String name;

  _homeTabState(this.name);

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
    return Card(
      color: Colors.white70,
      child: ListTile(
        title: Text(
          book.name,
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
