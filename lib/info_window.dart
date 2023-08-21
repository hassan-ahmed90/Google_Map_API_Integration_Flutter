import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class CustomMarkerInfoWindowScreen extends StatefulWidget {
  const CustomMarkerInfoWindowScreen({Key? key}) : super(key: key);
  @override
  _CustomMarkerInfoWindowScreenState createState() => _CustomMarkerInfoWindowScreenState();
}
class _CustomMarkerInfoWindowScreenState extends State<CustomMarkerInfoWindowScreen> {
  CustomInfoWindowController customInfoWindowController =
  CustomInfoWindowController();
  final LatLng _latLng = const LatLng(33.6844, 73.0479);
  final double _zoom = 15.0;
  Set<Marker> markers = {};

  List<String> images = [ 'images/car.png' , 'images/marker.png' ,];

  Uint8List? markerImage;



  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;

  }
  //Set<Marker> _markers = {};

  loadData()async{

    for(int i = 0 ; i < images.length ; i++){
      // print('name'+images[i].toString());
      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 100);

      if(i == 1 ){
        markers.add(Marker(
            markerId: const MarkerId('2'),
            position: const LatLng(33.6992,  72.9744),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "I am here",
                                style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Triangle.isosceles(
                    //   edge: Edge.BOTTOM,
                    //   child: Container(
                    //     color: Colors.blue,
                    //     width: 20.0,
                    //     height: 10.0,
                    //   ),
                    // ),
                  ],
                ),
                const LatLng(33.6992,  72.9744),
              );
            }
        ));
      }else {
        markers.add( Marker(
            markerId: MarkerId(i.toString()),
            position: const LatLng(33.6844, 73.0479),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(
                          image:  DecorationImage(
                              image:  NetworkImage('https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg'),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high),
                          borderRadius:  BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.red,
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(top: 10 , left: 10 , right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Beef Tacos',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                             Spacer(),
                            Text(
                              '.3 mi.',
                              // widget.data!.date!,

                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(top: 10 , left: 10 , right: 10),
                        child:  Text(
                          'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                          maxLines: 2,

                        ),
                      ),

                    ],
                  ),
                ),
                const LatLng(33.6844, 73.0479),
              );
            }
        ));
      }

      setState(() {

      });
    }



  }

  @override
  Widget build(BuildContext context) {
    // loadData() ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              customInfoWindowController.googleMapController = controller;
            },
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: _latLng,
              zoom: _zoom,
            ),
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Custom Marker Info Window"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(initialCameraPosition: CameraPosition(
//             target: LatLng(33.6941,72.9734)
//           ),
//             markers: Set<Marker>.of(_marker),
//             onTap: (postition){
//
//             },
//             onMapCreated: (GoogleMapController controller){
//               customMarkerInfoWindow .googleMapController = controller;
//             },
//           ),
//           CustomInfoWindow(
//             controller: customMarkerInfoWindow,
//           height: 200,
//           width: 300,
//           offset: 35,)
//
//         ],
//       ),
//     );
//   }
// }
