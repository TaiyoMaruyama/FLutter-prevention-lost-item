import 'package:flutter/material.dart';
import 'package:prevention_lost_item/topPage/topPage.dart';


void main() => runApp(mainPage());

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSerifJP-Regular.otf',
        primaryColor: Colors.orange,
        unselectedWidgetColor: Colors.black,
      ),
      home: const mainPageScreen(),
    );
  }
}
