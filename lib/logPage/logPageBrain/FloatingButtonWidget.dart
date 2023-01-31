import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../../tools/customFonts.dart';

class FloationgButtonWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Column(
        children: const [
          Icon(Icons.arrow_circle_up),
          Text('ナビ'),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.black.withOpacity(0.7),
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 30),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                  Text('使い方ナビ', style: customFont04),
                  const Divider(
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      '①「アプリを閉じても計測」を押し、'
                          '携帯本体の設定から「常に許可」を選択することで、'
                          'スマホを閉じても計測し続けます。',
                      style: customFont04,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(9.0),
                      child: StyledText(
                        text: '②それぞれのリストにある<map/>のアイコンを押せば、'
                            '忘れ物をした可能性のある住所をマップ上で検索できます。',
                        style: customFont04,
                        tags: {
                          'map': StyledTextIconTag(Icons.map,
                              color: Colors.white),
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      '③必要のないリストは、左右どちらからでもスライドする事で削除できます。',
                      style: customFont04,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(9.0),
                    child: StyledText(
                      text: '④画面右上の<menu/>を押し、'
                          '「感度をよくする」をオンにするとより正確な'
                          'ログが残ります。',
                      style: customFont04,
                      tags: {
                        'menu':
                        StyledTextIconTag(Icons.menu_outlined, color: Colors.white),
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('その他、使い方の注意事項はプレイストアの'
                      '説明欄に記載していますので、ご用の方はそちらをご覧ください。', style: customFont03,)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
