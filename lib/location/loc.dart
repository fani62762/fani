import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fani/profiles/edittech.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:http/http.dart' as http;

class Loc extends StatefulWidget {
  const Loc({required this.locName, super.key});
  final String locName;
  @override
  State<Loc> createState() => _LocState();
}

String ads = "";
double lat = 32.22111;
double lon = 35.25444;

class _LocState extends State<Loc> {
  Future<void> updateWorker(
      String name, String address, double latitude, double longitude) async {
    final body = jsonEncode(
        {'address': address, 'latitude': latitude, 'longitude': longitude});

    final response = await http.put(
      Uri.parse('https://fani-service.onrender.com/worker/location/$name'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker');
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("deny");
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Directionality(
                textDirection: TextDirection.rtl,
                child: Text('طلب الوصول الى موقعك')),
            content: Directionality(
                textDirection: TextDirection.rtl,
                child:
                    Text(' لتسهيل عملية وصول الزبائن اليك يرجى تحديد موقعك ')),
          );
        },
      );
    }

    if (permission == LocationPermission.deniedForever) {
      print("fo");
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Directionality(
                textDirection: TextDirection.rtl,
                child: Text('طلب الوصول الى موقعك')),
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                    ' لتسهيل عملية وصول الزبائن اليك يرجى السماح للتطبيق بتحديد موقعك ')),
          );
        },
      );
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("hhhh");
    print(position);
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("loc"),
      ),
      body: OpenStreetMapSearchAndPick(
        center: LatLong(lat, lon),
        buttonColor: Colors.blue,
        buttonText: 'خزن موقعي',
        onPicked: (pickedData) {
          // print("********");
          // print(lat + lon);
          ads = "";
          var addressParts = pickedData.address.split(',');
          for (var i = 0; i < addressParts.length; i++) {
            if (addressParts[i].contains('منطقة') ||
                addressParts[i].contains('שטח')) {
              break; // stop printing after the first occurrence of "منطقة"
            }
            ads += addressParts[i] + ", ";
            // print(addressParts[i]);
          }
          ads = ads
              .trim()
              .replaceAll(new RegExp(r',$'), ''); // remove trailing comma
          print(ads);
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'حفظ موقعك',
            desc: 'الموقع: $ads',
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              await updateWorker(widget.locName, ads,
                  pickedData.latLong.latitude, pickedData.latLong.longitude);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          editTech(techName: widget.locName)));
            },
          ).show();
        },
      ),
    );
  }
}
