// Наш новый менеджер навигации
import 'package:flutter/cupertino.dart';

import 'NavElement.dart';

class NavElementList extends StatefulWidget {
  final List<Item> items = []; // Список элементов навигации

  NavElementList({super.key});

  NavElementList add(Item item) {
    items.add(item);
    return this;
  }

  @override
  _NavElementListState createState() => _NavElementListState();
}

class _NavElementListState extends State<NavElementList> {
  String selected = ''; // текущий выбранный элемент

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((i) {
        return NavElement(
          isSelected: selected == i.label,
          label: i.label,
          icon: i.icon,
          onTap: () {
            select(i.label); // выбор текущего элемента
            i.onTap.call(); // выполняем связанный коллбэк
          },
        );
      }).toList(),
    );
  }

  // Выбор элемента по индексу
  void select(String label) {
    if (selected != label) {
      setState(() {
        selected = label; // обновляем активное состояние
      });
    }
  }
}

class Item {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  Item({required this.label, required this.icon, required this.onTap});
}
