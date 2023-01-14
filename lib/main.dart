import 'package:flutter/material.dart';

import 'model.dart';

void main() => runApp(mainPage());

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        unselectedWidgetColor: Colors.black,
      ),
      home: mainPageScreen(),
    );
  }
}

class mainPageScreen extends StatefulWidget {
  const mainPageScreen({Key? key}) : super(key: key);

  @override
  State<mainPageScreen> createState() => _mainPageScreenState();
}

class _mainPageScreenState extends State<mainPageScreen> {
  final allChecked = checkBoxState('All checked', false);
  final checkBoxList = [
    checkBoxState('Checked01', false),
    checkBoxState('Checked02', false),
    checkBoxState('Checked03', false),
    checkBoxState('Checked04', false),
    checkBoxState('Checked05', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => onAllClicked(allChecked),
            leading: Checkbox(
              value: allChecked.value,
              onChanged: (bool? value) => onAllClicked(allChecked),
            ),
            title: Text(allChecked.title),
          ),
          const Divider(),
          ...checkBoxList.map(
            (e) => ListTile(
              onTap: () => onAllClicked(e),
              leading: Checkbox(
                value: e.value,
                onChanged: (bool? value) => onAllClicked(e),
              ),
              title: Text(e.title),
            ),
          )
        ],
      ),
    );
  }

  onAllClicked(checkBoxState Item) {
    setState(() {
      Item.value = !Item.value;
    });
  }
}
