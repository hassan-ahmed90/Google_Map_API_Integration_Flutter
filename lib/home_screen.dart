import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homecreen extends StatefulWidget {
  const Homecreen({Key? key}) : super(key: key);

  @override
  State<Homecreen> createState() => _HomecreenState();
}

class _HomecreenState extends State<Homecreen> {

  List <Marker> _marker =[];
  List<Marker> _list= const [
    Marker(markerId: MarkerId('1'),
        position: LatLng(25.7637400, 68.6609800),
        infoWindow: InfoWindow(
            title:'My current loacation'
        )
    ),
    Marker(markerId: MarkerId('2'),
        position: LatLng(25.357255, 68.356447),
        infoWindow: InfoWindow(
            title:'near Akram Biryani'
        )
    )
    // Marker(markerId: MarkerId("1"),
    // position: LatLng(37.42796133580664, -122.085749655962),
    //     // 25.7682° N, 68.6559° E
    //   infoWindow: InfoWindow(
    //     title: "My Position"
    //   )
    // ),
    // Marker(markerId: MarkerId("1"),
    //     position: LatLng(25.7682, 68.6559),
    //     // 25.7682° N, 68.6559° E
    //     infoWindow: InfoWindow(
    //         title: "Current Position"
    //     )
    // )
      ];
  Completer<GoogleMapController> _controller = Completer();
  static final  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.7637400, 68.6609800),
    zoom: 14.4746,
  );

  // static final CameraPosition _kGooglePlex= CameraPosition(
  //     target: LatLng(37.42796133580664,-122.085749655962),
  //   zoom: 14.4746,

  // );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: GoogleMap(
          markers: Set<Marker>.of(_marker),
          initialCameraPosition:_kGooglePlex,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          // compassEnabled: true,
          // myLocationEnabled: false,

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          setState(() {
            
          });
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition( target: LatLng(25.7637400, 68.6609800),
            zoom: 14.4746,))

          );

        },
      ),
    );
  }
}
