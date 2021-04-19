import 'package:flutter/material.dart';

import '../widgets/form_name.dart';
import '../widgets/button.dart';
import '../widgets/possible_dates_table.dart';

class AttendeesScreen extends StatefulWidget {
  @override
  _AttendeesScreenState createState() => _AttendeesScreenState();
}

class _AttendeesScreenState extends State<AttendeesScreen> {
  // jsonファイルからデータを抜き出す。
  // {"dates": ["2021-04-07 00:00:00.000","2021-04-13 00:00:00.000","2021-04-24 00:00:00.000","2021-04-28 00:00:00.000"]}
  // デコードするとこうなる
  // https://algorithm.joho.info/dart/object-string-json-dart/

  //
  // サンプルのデータを表示する。
  // テーブルで表示して、参加可能日を選択する。
  // 選択結果のjsonをrailsへ送信する。
  // 送信中はloading画面を表示する。
  // 完了画面を表示する。
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child: SizedBox(
          width: 960,
          child: Column(
            children: [
              Nameform(),
              PossibleDatesTable(),
              DefaultButton(),
            ],
          ),
        ),
      ),
    );
  }
}
