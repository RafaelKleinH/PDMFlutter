import 'package:flutter/cupertino.dart';

class homeView extends StatefulWidget {
  final int id_usuario;
  homeView({Key? key, required this.id_usuario}) : super(key: key);


  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  List<Widget> _tabs = [
    homeTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("E-Books"),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: "Settings")
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
    );
  }
}

class homeTab extends StatefulWidget {
  homeTab({Key? key}) : super(key: key);

  @override
  _homeTabState createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home'),
    );
  }
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}
