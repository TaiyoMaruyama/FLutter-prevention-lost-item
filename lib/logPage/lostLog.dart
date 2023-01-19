import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';
import 'package:prevention_lost_item/tools/getLocation.dart';

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
  List logTimeLIst = [
    '09:00',
    '09:00',
    '09:00',
  ];
  List logLocationList = [
    '大阪府西淀川区です。',
    '大阪府西淀川区です。',
    '大阪府西淀川区です。',
  ];

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
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => getLocation()));
                  },
                  icon: const Icon(Icons.menu_outlined),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: LogPageTopCard(widget: widget),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: logTimeLIst.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            logTimeLIst[index],
                            style: customFont02,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            logLocationList[index],
                            style: customFont02,
                          ),
                        ),
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

