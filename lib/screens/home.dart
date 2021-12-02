import 'package:flutter/cupertino.dart';
import 'package:pdmapp/screens/homeScreens/createNewBook.dart';
import 'package:pdmapp/screens/homeScreens/favoriteBooks.dart';

import 'homeScreens/homeTab.dart';
import 'homeScreens/settingsTab.dart';

class homeView extends StatefulWidget {
  homeView({Key? key}) : super(key: key);

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  List<Widget> _tabs = [
    homeTab("Jurandir"),
    createBookTab(),
    favoritesTab(),
    SettingsTab("Rafael"),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.15),
        middle: Text(
          "E-Books",
          style: TextStyle(color: CupertinoColors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 18.0,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.15),
            inactiveColor: Color.fromRGBO(255, 255, 255, 1.0),
            activeColor: Color.fromRGBO(81, 160, 213, 1.0),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'Inicio'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), label: 'Novo Livro'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.star), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: "Opções")
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
    );
  }
}
