import 'package:flutter/material.dart';
import 'package:flutterjsoncomplex/Json_Parsing_Complex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JSON PARSING COMPLEX",
      home: JsonParsingComplex(),
    );
  }
}
