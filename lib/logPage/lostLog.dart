import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'logPageBrain/FloatingButtonWidget.dart';
import 'logPageBrain/diaogForLocationSetting.dart';
import 'logPageBrain/logLIstView.dart';
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
    getLocationEveryTime(countInterval);
  }

  //Drawer tools.
  bool _active = false;

  void _changed(bool active) {
    setState(() {
      _active = active;
    });
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
  double compareListAverage = 0;
  late Timer timered;
  int beforeSpeedRank = 0;
  late int nowSpeedRank = 0;
  bool judge = true;
  int countInterval = 20;

  //get location and then speed function.
  void getLocationAndSpeed() async {
    Location location = Location();
    LocationData locationData;

    locationData = await location.getLocation();
    speedList.add(locationData.speed);
    latitudeList.add(locationData.latitude);
    longitudeList.add(locationData.longitude);
    timeList.add(DateTime.now().toString().substring(11, 16));
    setState(() {});
  }

  //get every time location function.
  void getLocationEveryTime(int countTime) {
    setState(() {
      timered = Timer.periodic(Duration(seconds: countTime), (timer) {
        getLocationAndSpeed();
        judgeSpeed();
      });
    });
  }

  //judge speed rank.
  void judgeSpeed() {
    List compareList;
    if (speedList.length >= 8) {
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
    setState(() {});
  }

  void judgeSpeedBrain(double speedAvg) {
    if (speedAvg < 1.8) {
      nowSpeedRank = 1;
      if (nowSpeedRank != beforeSpeedRank) {
        judge = false;
        beforeSpeedRank = 1;
      }
    } else if (speedAvg < 3.6) {
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
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            timered.cancel();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.lightGreen),
              child: Text('?????????', style: customFont04),
            ),
            SwitchListTile(
              value: _active,
              onChanged: _changed,
              activeColor: const Color(0xFF006400),
              title: Text('?????????????????????', style: customFont02),
            ),
            SizedBox(height: 100.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006400),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (_active) {
                        countInterval = 10;
                        timered.cancel();
                        getLocationEveryTime(countInterval);
                      } else {
                        countInterval = 12;
                        timered.cancel();
                        getLocationEveryTime(countInterval);
                      }
                    });
                  },
                  child: Text('??????', style: customFont03)),
            )
          ],
        ),
      ),
      floatingActionButton: FloationgButtonWidget(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
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
                      return locationSettingAlertDialog();
                    },
                  );
                },
                child: Text('??????????????????????????????', style: customFont02)),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: logListView(
                  speedLogList: speedLogList,
                  timeLogList: timeLogList,
                  latitudeLogList: latitudeLogList,
                  longitudeLogList: longitudeLogList),
            ),
          ],
        ),
      ),
    );
  }
}
