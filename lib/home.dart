import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        color: Colors.black38,
        child: Text(
          'Welcome you did it',
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
      ),
    );
  }
}
