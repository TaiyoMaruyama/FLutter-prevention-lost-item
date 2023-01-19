import 'package:flutter/material.dart';

import '../logPage/lostLog.dart';
import 'model.dart';

class mainPageScreen extends StatefulWidget {
  const mainPageScreen({Key? key}) : super(key: key);

  @override
  State<mainPageScreen> createState() => _mainPageScreenState();
}

class _mainPageScreenState extends State<mainPageScreen> {
  List selectedList = [];
  final allChecked = checkBoxState('全部忘れそう・・・', false);
  final checkBoxList = [
    checkBoxState('財布', false),
    checkBoxState('カギ', false),
    checkBoxState('カバン', false),
    checkBoxState('カード', false),
    checkBoxState('傘', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              '忘れそうなものに、予めチェックを入れてください。',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () => onAllClicked(allChecked),
            leading: Checkbox(
              activeColor: Colors.orange,
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
                activeColor: Colors.orange,
                value: e.value,
                onChanged: (bool? value) => onItemClicked(e),
              ),
              title: Text(e.title),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedList = [];
                  for(var element in checkBoxList){
                    if(element.value){
                      selectedList.add(element.title);
                    }
                  }
                });
                if (checkBoxList.any((element) => element.value) != true) {
                  null;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LostItemLogPage(selectedList)));
                }
              },
              child: Text('次へ'),
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor:
                    checkBoxList.any((element) => element.value) != true
                        ? Colors.grey
                        : Colors.orange,
              ),
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
        }
      },
    );
  }
}
