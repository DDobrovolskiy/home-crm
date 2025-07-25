import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/screen/screen_info.dart';

import '../../cookie/cookie_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenInfo(context).isMobile
        ? MobileHomePage().build(context)
        : DesktopHomePage().build(context);
  }
}

class MobileHomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Заголовок: Mobile'),
      ),
      body: Center(
        child: Text('Контент'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Добавить элемент',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Меню'),
            ),
            ListTile(title: Text('Главная')),
            ListTile(title: Text('Настройки')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Домой'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
        ],
      ),
    );
  }
}

class DesktopHomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CookieHandler().getValue("key")
    .then((value) {
      print("cookies = $value");
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Заголовок: Desktop'),
      ),
      body: Center(
        child: Text('Контент'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Добавить элемент',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Меню'),
            ),
            ListTile(title: Text('Главная')),
            ListTile(title: Text('Настройки')),
          ],
        ),
      ),
    );
  }
}