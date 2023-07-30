import 'package:flutter/material.dart';
import 'package:map_finally/converstion_adress_cordinates.dart';
import 'package:map_finally/google_places_api.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GooglePlacesApiScreen(),
    );
  }
}
