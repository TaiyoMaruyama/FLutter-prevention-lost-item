import 'package:flutter/material.dart';

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
              Text('緯度：${latitudeLogList[index]}'),
              Text('経度：${longitudeLogList[index]}'),
            ],
          ),
        );
      },
    );
  }
}
