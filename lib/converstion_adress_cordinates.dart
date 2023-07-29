import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class Conversion extends StatefulWidget {
  const Conversion({Key? key}) : super(key: key);

  @override
  State<Conversion> createState() => _ConversionState();
}

class _ConversionState extends State<Conversion> {
  String stAddress='',stAdd='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap: ()async{

              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
              //final query = "1600 Amphiteatre Parkway, Mountain View";


              // final coordinates=new Coordinates(25.361064, 68.350958);

              setState(() {
                stAddress=locations.last.latitude.toString()+" "+locations.last.longitude.toString();
                stAdd=placemarks.reversed.last.country.toString();
              });


            },
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.yellowAccent,
              child: Center(child: Text('Convert'),),
            ),
          )

        ],
      ),
    );
  }
}
