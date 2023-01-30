import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../tools/customFonts.dart';

String MapLink = 'https://www.google.com/maps/place/';
late Uri _uri;

class logListView extends StatelessWidget {
  const logListView({
    Key? key,
    required this.speedLogList,
    required this.timeLogList,
    required this.latitudeLogList,
    required this.longitudeLogList,
  }) : super(key: key);

  final List speedLogList;
  final List timeLogList;
  final List latitudeLogList;
  final List longitudeLogList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: timeLogList.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(timeLogList.toString()),
          onDismissed: (direction) {
            timeLogList.removeAt(index);
            latitudeLogList.removeAt(index);
            longitudeLogList.removeAt(index);
          },
          background: Row(
            children: [
              const Icon(Icons.delete_forever_outlined, color: Colors.red),
              Text('削除', style: errorFont),
            ],
          ),
          secondaryBackground: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('削除', style: errorFont),
              const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6.0,
                  offset: const Offset(0, 5),
                ),
              ],
              color: const Color(0xFF006400),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(timeLogList[index], style: customFont04),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('緯度：${latitudeLogList[index]}', style: customFont03),
                      Text('経度：${longitudeLogList[index]}', style: customFont03),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _uri = Uri.parse(MapLink + latitudeLogList[index].toString() + ' , '
                        + longitudeLogList[index].toString());
                    launchUrl(_uri);
                  },
                  icon: const Icon(Icons.map, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
