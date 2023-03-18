import 'package:flutter/material.dart';
import 'package:movie_infos/Screens/itemScreen.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie infos',
      theme: ThemeData(),
      home: const ItemScreen(),
    );
  }
}
