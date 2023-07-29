import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(25.361064, 68.350958),
    zoom: 14,
  );
  final List<Marker> _markers = <Marker> [
    Marker(markerId: MarkerId('1'),
        position: LatLng(25.361064, 68.350958),
        infoWindow: InfoWindow(
            title:'The Title of marker'
        )
    )];
  loadData(){

    getUserCurrentLocation().then((value) async{
      _markers.add(
       Marker(markerId: MarkerId("2"),
       position: LatLng(value.latitude,value.longitude),
         infoWindow: InfoWindow(
           title: "MY Current Location",
         )
       ),
      );
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude,value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });

  }
  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.local_activity),
        onPressed: (){

        },
      ),

    );
  }
}
