import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar({Key key}) : super(key: key);

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Restaurant",
      ),
      centerTitle: true,
    );
  }
}
