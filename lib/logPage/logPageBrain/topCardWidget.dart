import 'package:flutter/material.dart';

import '../../tools/customFonts.dart';
import '../lostLog.dart';

class LogPageTopCard extends StatelessWidget {
  const LogPageTopCard({Key? key, required this.widget}) : super(key: key);

  final LostItemLogPage widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('今回のお出かけは、', style: customFont02),
          Text(lostItem(widget.LostItemList), style: customFont01),
          Text('を忘れないようにしましょう！', style: customFont02),
        ],
      ),
    );
  }
}