import 'package:flutter/material.dart';


class LostItemLogPage extends StatefulWidget {
  LostItemLogPage(this.LostItemList);
  List LostItemList;


  @override
  State<LostItemLogPage> createState() => _LostItemLogPageState();
}

lostItem(List lists){
  String allLostItem = '';
  for(var list in lists){
    allLostItem = allLostItem + list + ' ';
  }
  return allLostItem;
}


class _LostItemLogPageState extends State<LostItemLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(lostItem(widget.LostItemList)),
      )
    );
  }
}

