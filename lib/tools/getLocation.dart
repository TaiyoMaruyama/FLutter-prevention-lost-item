import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class getLocation extends StatefulWidget {
  const getLocation({Key? key}) : super(key: key);

  @override
  State<getLocation> createState() => _getLocationState();
}

class _getLocationState extends State<getLocation> {
  late double Latitude;
  late double Longitude;
  late Timer timered;
  late int getLocationCounter = 0;
  late double twoPointDistance;
  List LatitudePointList = [];
  List LongitudePoinntList = [];

  @override
  void initState() {
    super.initState();
    getLocation();
    getEverTimeLocation();
  }

  // Geolocatorで現在地の取得
  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('現在地を取得できません。');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    Latitude = position.latitude;
    Longitude = position.longitude;
    LatitudePointList.add(Latitude);
    LongitudePoinntList.add(Longitude);
  }

  void getEverTimeLocation() {
    timered = Timer.periodic(const Duration(seconds: 3), (timer) {
      getLocation();
      getLocationCounter++;
      if(getLocationCounter == 1){
        LatitudePointList.add(Latitude);
        LongitudePoinntList.add(Longitude);
      }else{
        LatitudePointList.add(Latitude);
        LongitudePoinntList.add(Longitude);
        LatitudePointList.removeAt(0);
        LongitudePoinntList.removeAt(0);
      }
      print(LongitudePoinntList);
    });
    timered;
  }

  // void distanceCalculation(){
  //   twoPointDistance =
  // }

  void timerStop (){
    timered!.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: (){

        },
        child: const Text('timer stop!'),
      ),
    );
  }
}
