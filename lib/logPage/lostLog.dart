import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';
import 'package:location/location.dart';
import 'dart:async';
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
  double compareListAverage = 0;
  late Timer timered;
  int beforeSpeedRank = 0;
  late int nowSpeedRank = 0;
  bool judge = true;

  //test
  int counter = 0;

  //get location and then speed function.
  void getLocationAndSpeed() async {
    Location location = Location();
    LocationData locationData;

    locationData = await location.getLocation();
    speedList.add(locationData.speed);
    latitudeList.add(locationData.latitude);
    longitudeList.add(locationData.longitude);
    timeList.add(DateTime.now().toString().substring(11, 16));
    counter++;
    setState(() {});
  }

  //get every time location function.
  void getLocationEveryTime() {
    setState(() {
      timered = Timer.periodic(const Duration(seconds: 11), (timer) {
        getLocationAndSpeed();
        judgeSpeed();
      });
    });
  }

  //judge speed rank.
  void judgeSpeed() {
    List compareList;
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
              child: Text('その他の設定', style: customFont03,),
              decoration: BoxDecoration(color: Color(0xFF006400)),
            ),
          ],
        ),
      ),
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
                child: Text('アプリを閉じても計測', style: customFont02)),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 10,
              child: logListView(
                  speedLogList: speedLogList,
                  timeLogList: timeLogList,
                  latitudeLogList: latitudeLogList,
                  longitudeLogList: longitudeLogList),
            ),
            Expanded(flex: 1, child: Text(speedList.toString())),
            Expanded(
                flex: 1,
                child: Text('現在の平均速度：${compareListAverage.toString()} m/s')),
            Expanded(flex: 1, child: Text('速度Rank：${nowSpeedRank.toString()}')),
            Expanded(flex: 1, child: Text('代入回数：${counter.toString()}')),
          ],
        ),
      ),
    );
  }
}
