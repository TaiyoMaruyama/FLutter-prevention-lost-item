import 'package:flutter/material.dart';
import 'package:prevention_lost_item/tools/customFonts.dart';


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
        padding: const EdgeInsets.only(top: 50.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('今回のお出かけは、', style: customFont02,),
                    Text(lostItem(widget.LostItemList), style: customFont01,),
                    Text('を忘れないようにしましょう！', style: customFont02,),
                  ],
                ),
              ),
            ),
            Container(

            )
          ],
        ),
      )
    );
  }
}

