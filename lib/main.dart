
import 'package:flutter/material.dart';
import 'package:proje02/ortalama_Hesapla.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Dinamik Note Ortalama",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: OrtalamaHesapla(),

    );

  }
}
