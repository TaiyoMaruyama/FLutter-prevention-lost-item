import 'package:flutter/material.dart';

void main() => runApp(mainPage());

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          children: [
            Text(
              '忘れものしそうなものに予めチェックを入れてください。',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(10.0, 10.0),
                        color: Colors.black,
                      ),
                    ],
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CheckboxListTile(
                    title: Text('wallet'),
                    secondary: Icon(Icons.account_circle),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checked,
                    onChanged: (bool? value) {
                      setState(() {
                        _checked = value!;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
