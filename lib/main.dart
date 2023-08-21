import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_finally/custom_marker.dart';
import 'package:map_finally/google_places_api.dart';
import 'package:map_finally/polygon_screen.dart';
import 'package:map_finally/polylines_two.dart';
import 'package:map_finally/styling_map.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoolgeMapStyling(),
    );
  }
}
