import 'dart:async';
import 'dart:math';

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
  double twoPointDistance = 0;
  double betweentwoPointspeed = 0;
  List<double> LatitudePointList = [];
  List<double> LongitudePointList = [];

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
  }

  void getEverTimeLocation() async {
    timered = Timer.periodic(const Duration(seconds: 5), (timer) {
      getLocation();
      getLocationCounter++;
      if (getLocationCounter <= 2) {
        LatitudePointList.add(Latitude);
        LongitudePointList.add(Longitude);
      } else {
        LatitudePointList.add(Latitude);
        LongitudePointList.add(Longitude);
        LatitudePointList.removeLast();
        LongitudePointList.removeLast();
        double latitudeDifference = LatitudePointList[1] - LatitudePointList[0];
        double longitudeDifference = LongitudePointList[1] - LongitudePointList[0];
        twoPointDistance = sqrt(pow(latitudeDifference, 2) + pow(longitudeDifference, 2));
        betweentwoPointspeed = twoPointDistance / 2 ;
        setState(() {});
      }
    });
    timered;
    Text(betweentwoPointspeed.toString());
  }

  void timerStop() {
    timered!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Latitude.toString()),
            Text(Longitude.toString()),
            Text(twoPointDistance.toString()),
            Text(getLocationCounter.toString()),
            Text(betweentwoPointspeed.toString()),
            ElevatedButton(
              onPressed: () {
                timerStop();
              },
              child: const Text('timer stop!'),
            ),
          ],
        ),
      ),
    );
  }
}
