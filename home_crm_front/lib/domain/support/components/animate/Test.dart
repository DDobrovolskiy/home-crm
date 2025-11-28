import 'package:flutter/material.dart';

// class CounterWrap extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     int counter = 0;
//     print('counter: $counter');
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) => Column(
//       children: <Widget>[
//         Text(counter.toString()),
//         IconButton(onPressed: () {
//           setState(() {
//             counter++;
//           });
//         }, icon: Icon(Icons.add))
//       ],
//     ),
//     );
//   }
//
// }

class CounterWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = 0;
    print('counter: $counter');
    return Counter(
      counter: (i) {
        counter = counter + i;
        return counter;
      },
    );
  }
}

class Counter extends StatefulWidget {
  Counter({super.key, required this.counter});

  final int Function(int) counter;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    print('counter: ${widget.counter(0)}');
    return Column(
      children: [
        Text(widget.counter(0).toString()),
        IconButton(
          onPressed: () {
            setState(() {
              widget.counter(1);
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
