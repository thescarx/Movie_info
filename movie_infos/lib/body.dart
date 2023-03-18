import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedCategory = 0;
  List<String> categories = ['For you', 'In Theatre', 'Box Office'];
  List<String> genres = [
    'All',
    'Crime',
    'Drama',
    'Cy-fy',
    'Adventure',
    'Documentary',
    'Fiction'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }

  
}
