// Flutter imports:
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(':hand-shake:こんにちは！執事のツジです:hitsuji:'),
        Text('会社の飲み会、クラスメイトとの日程調整をします！'),
        Text('使い方はかんたん3ステップ'),
        Text('1. イベントを作成して、URLを共有！'),
        Text('2. みんなで参加可能日を入力！'),
        Text('3. 参加表を確認して、イベント日を決定！'),
      ],
    ));
  }
}
