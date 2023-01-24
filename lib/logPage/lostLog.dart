import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'logPageBrain/topCardWidget.dart';

class LostItemLogPage extends StatefulWidget {
  LostItemLogPage(this.LostItemList);

  List LostItemList;

  @override
  State<LostItemLogPage> createState() => _LostItemLogPageState();
}

lostItem(List lists) {
  String allLostItem = '';
  for (var list in lists) {
    allLostItem = allLostItem + list + ' ';
  }
  return allLostItem;
}

class _LostItemLogPageState extends State<LostItemLogPage> {
  List logTimeList = [];
  List logLocationList = [];

  double Latitude = 0;
  double Longitude = 0;
  late Timer timered;
  late int getLocationCounter = 0;
  double twoPointDistance = 0;
  double betweenTwoPointSpeed = 0;
  List<double> LatitudePointList = [];
  List<double> LongitudePointList = [];
  List<double> averageSpeedList = [];
  double speedAverage = 0;
  int speedRankBefore = 0;
  late int speedRankAfter;
  bool judge = true;

  @override
  void initState() {
    super.initState();
    getLocation();
    getEverTimeLocation();
  }


  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    Latitude = _locationData.latitude!;
    Longitude = _locationData.longitude!;

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('現在地を取得できません。');
    //   }
    // }
    // Position position = await Geolocator.getCurrentPosition();
    // Latitude = position.latitude;
    // Longitude = position.longitude;
  }

  void getEverTimeLocation() {
    timered = Timer.periodic(const Duration(seconds: 8), (timer) {
      print(Longitude.toString());
      print(Latitude.toString());
      getLocation();
      getLocationCounter++;
      if (getLocationCounter <= 2) {
        LatitudePointList.add(Latitude);
        LongitudePointList.add(Longitude);
      } else {
        LatitudePointList.add(Latitude);
        LongitudePointList.add(Longitude);
        LatitudePointList.removeAt(0);
        LongitudePointList.removeAt(0);
        double latitudeDifference = LatitudePointList[1] - LatitudePointList[0];
        double longitudeDifference =
            LongitudePointList[1] - LongitudePointList[0];
        twoPointDistance =
            sqrt(pow(latitudeDifference, 2) + pow(longitudeDifference, 2));
        betweenTwoPointSpeed = twoPointDistance * 10000 / 2;
        averageSpeed(betweenTwoPointSpeed);
        setState(() {});
      }
    });
    timered;
  }

  void averageSpeed(double speed) {
    averageSpeedList.add(speed);
    if (averageSpeedList.length == 9) {
      speedAverage = averageSpeedList.reduce((a, b) => a + b) / 10;
      averageSpeedList.clear();
      if (speedAverage <= 1) {
        speedRankAfter = 1;
        speedRankBefore == speedRankAfter ? judge = true : judge = false;
        speedRankBefore = 1;
      } else if (speedAverage <= 2) {
        speedRankAfter = 2;
        speedRankBefore == speedRankAfter ? judge = true : judge = false;
        speedRankBefore = 2;
      } else {
        speedRankAfter = 3;
        speedRankBefore == speedRankAfter ? judge = true : judge = false;
        speedRankBefore = 3;
      }
      logAction(judge);
    }
  }

  void logAction(bool judge) async {
    if (judge == false) {
      DateTime now = DateTime.now();
      logTimeList.add(now.toString().substring(11, 16));
      logLocationList.add(Latitude);
      judge = true;
    }
  }

  void timerStop() {
    timered!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu_outlined),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: LogPageTopCard(widget: widget),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 20,
              child: ListView.builder(
                itemCount: logLocationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text(logTimeList[index], style: customFont02)),
                        Expanded(
                            flex: 4,
                            child: Text(logLocationList[index].toString(),
                                style: customFont02)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(flex: 1, child: Text(Latitude.toString())),
            Expanded(flex: 1, child: Text(Longitude.toString())),
            Expanded(flex: 1, child: Text(averageSpeedList.toString())),
          ],
        ),
      ),
    );
  }
}
