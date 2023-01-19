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

  void getEverTimeLocation() {
    Timer timered = Timer.periodic(const Duration(seconds: 10), (timer) {
      getLocation();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: (){},
        child: const Text('timer stop!'),
      ),
    );
  }
}
