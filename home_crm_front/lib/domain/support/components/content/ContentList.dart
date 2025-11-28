import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../callback/NavBarCallBack.dart';

class ContentList extends StatefulWidget {
  ContentList({super.key});

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  final Map<String, Widget> contents = {};

  // final Map<String, Widget Function()> contents = {};
  String selected = '';

  _ContentListState() {
    GetIt.I.get<SheetElementAddCallback>().subscribe((element, content) {
      setState(() {
        selected = element;
        if (!contents.containsKey(element)) {
          print('insert');
          contents[element] = content();
        }
      });
    });
    GetIt.I.get<SheetElementSelectCallback>().subscribe((element) {
      print(contents);
      setState(() {
        selected = element;
      });
    });
    GetIt.I.get<SheetElementDeleteCallback>().subscribe((element) {
      setState(() {
        contents.remove(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    print(selected);
    var content = contents[selected];
    if (content != null) {
      return content;
    }
    return Text('no content');
  }
}
