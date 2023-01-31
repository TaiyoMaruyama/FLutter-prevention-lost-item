import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';

import '../logPage/logPageBrain/diaogForLocationSetting.dart';
import '../logPage/lostLog.dart';
import 'model.dart';

class mainPageScreen extends StatefulWidget {
  const mainPageScreen({Key? key}) : super(key: key);

  @override
  State<mainPageScreen> createState() => _mainPageScreenState();
}

class _mainPageScreenState extends State<mainPageScreen> {
  @override
  void initState() {
    super.initState();
  }

  List selectedList = [];
  final allChecked = checkBoxState('全部忘れそう・・・', false);
  final checkBoxList = [
    checkBoxState('財布', false),
    checkBoxState('カギ', false),
    checkBoxState('カバン', false),
    checkBoxState('カード', false),
    checkBoxState('傘', false),
  ];

  //error message when selectBox is empty.
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              child: Text('忘れそうなものに、予めチェックを入れてください。', style: customFont01)),
          ListTile(
            onTap: () => onAllClicked(allChecked),
            leading: Checkbox(
              activeColor: Color(0xFF006400),
              value: allChecked.value,
              onChanged: (bool? value) => onAllClicked(allChecked),
            ),
            title: Text(allChecked.title),
          ),
          const Divider(),
          ...checkBoxList.map(
            (e) => ListTile(
              onTap: () => onItemClicked(e),
              leading: Checkbox(
                activeColor: Color(0xFF006400),
                value: e.value,
                onChanged: (bool? value) => onItemClicked(e),
              ),
              title: Text(e.title),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedList = [];
                      for (var element in checkBoxList) {
                        if (element.value) {
                          selectedList.add(element.title);
                        }
                      }
                    });
                    if (checkBoxList.any((element) => element.value) != true) {
                      setState(() {
                        errorMessage = '「忘れそうなもの」に１個以上チェックを入れてください。';
                      });
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LostItemLogPage(selectedList)));
                    }
                  },
                  child: Text(
                    '次へ',
                    style: customFont03,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation:
                        checkBoxList.any((element) => element.value) != true
                            ? 0
                            : 10.0,
                    backgroundColor:
                        checkBoxList.any((element) => element.value) != true
                            ? Color(0xFF006400).withOpacity(0.4)
                            : Color(0xFF006400),
                  ),
                ),
                Text(errorMessage, style: errorFont),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onAllClicked(checkBoxState Item) {
    final newValue = !Item.value;
    setState(() {
      Item.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(checkBoxState Item) {
    final newValue = !Item.value;
    setState(
      () {
        Item.value = newValue;
        if (!newValue) {
          allChecked.value = false;
        } else {
          final allListChecked = checkBoxList.every((element) => element.value);
          allChecked.value = allListChecked;
          errorMessage = '';
        }
      },
    );
  }
}
