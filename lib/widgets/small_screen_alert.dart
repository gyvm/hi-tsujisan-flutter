// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../common/hexcolor.dart';

class SmallScreenAlert extends StatelessWidget {
  const SmallScreenAlert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              '※スマホでご覧の方へ。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            Text(
              'サイトのデザインが崩れている場合、',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            Text(
              'PCからアクセスをお願いします。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
