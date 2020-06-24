import 'package:flutter/material.dart';
import 'package:suflex/app/modules/home/home-page.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Suflex',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}