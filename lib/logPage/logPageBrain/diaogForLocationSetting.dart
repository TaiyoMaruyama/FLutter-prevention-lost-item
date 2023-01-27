import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../tools/customFonts.dart';

class locationSettingAlertDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('位置情報について', style: customFont02),
      content: Text('アプリを閉じても計測するためには、設定画面へ遷移し権限から位置情報を「常に許可」にしてください。',
          style: customFont02),
      actions: [
        TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: Text('設定に移動する', style: customFont03)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('キャンセル', style: customFont03)),
      ],
    );
  }
}
