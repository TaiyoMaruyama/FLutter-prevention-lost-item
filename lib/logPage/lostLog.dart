import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';
import 'package:location/location.dart';
import 'dart:async';
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
  @override
  void initState() {
    super.initState();
    getLocationAndSpeed();
    getLocationEveryTime();
  }

  //List
  List speedList = [];
  List latitudeList = [];
  List longitudeList = [];
  List timeList = [];

  //these are lists for result.
  List speedLogList = [];
  List latitudeLogList = [];
  List longitudeLogList = [];
  List timeLogList = [];

  //use in judgeSpeedBrain and judgeSpeed.
  late Timer timered;
  int beforeSpeedRank = 0;
  late int nowSpeedRank = 0;
  bool judge = true;

  //get location and then speed function.
  void getLocationAndSpeed() async {
    Location location = Location();
    LocationData locationData;

    locationData = await location.getLocation();
    speedList.add(locationData.speed);
    latitudeList.add(locationData.latitude);
    longitudeList.add(locationData.longitude);
    timeList.add(DateTime.now().toString().substring(11, 16));
  }

  void getLocationPermission() async {}

  //get every time location function.
  void getLocationEveryTime() {
    timered = Timer.periodic(const Duration(seconds: 11), (timer) {
      getLocationAndSpeed();
      setState(() {});
      judgeSpeed();
    });
  }

  //judge speed rank.
  void judgeSpeed() {
    List compareList;
    double compareListAverage;
    if (speedList.length >= 7) {
      compareList = speedList.sublist(0, 6);
      compareListAverage =
          compareList.reduce((value, element) => value + element) / 7;
      judgeSpeedBrain(compareListAverage);
      if (judge == false) {
        speedLogList.add(speedList[3]);
        latitudeLogList.add(latitudeList[3]);
        longitudeLogList.add(longitudeList[3]);
        timeLogList.add(timeList[3]);
      }
      judge = true;
      speedList.removeRange(0, 6);
      latitudeList.removeRange(0, 6);
      longitudeList.removeRange(0, 6);
      timeList.removeRange(0, 6);
    }
  }

  void judgeSpeedBrain(double speedAvg) {
    if (speedAvg < 1.0) {
      nowSpeedRank = 1;
      if (nowSpeedRank != beforeSpeedRank) {
        judge = false;
        beforeSpeedRank = 1;
      }
    } else if (speedAvg < 5.0) {
      nowSpeedRank = 2;
      if (nowSpeedRank != beforeSpeedRank) {
        judge = false;
        beforeSpeedRank = 2;
      }
    } else {
      nowSpeedRank = 3;
      if (nowSpeedRank != beforeSpeedRank) {
        judge = false;
        beforeSpeedRank = 3;
      }
    }
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
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 5.0,
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text('位置情報について', style: customFont02),
                        content: Text('設定画面へ遷移し、権限から位置情報を「常に許可」にしてください。',
                            style: customFont02),
                        actions: [
                          TextButton(
                              onPressed: () {
                                openAppSettings();
                                Navigator.of(context).pop(0);
                              },
                              child: Text('設定に移動する', style: customFont03)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('キャンセル', style: customFont03)),
                        ],
                      );
                    },
                  );
                },
                child: Text('位置情報の許可', style: customFont02)),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: speedLogList.length,
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
                        Text(timeLogList[index]),
                        Text('経度：${latitudeLogList[index]}'),
                        Text('緯度：${longitudeLogList[index]}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
