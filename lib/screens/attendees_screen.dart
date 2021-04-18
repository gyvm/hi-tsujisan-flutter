import 'package:flutter/material.dart';

class AttendeesScreen extends StatefulWidget {
  @override
  _AttendeesScreenState createState() => _AttendeesScreenState();
}

class _AttendeesScreenState extends State<AttendeesScreen> {
  // jsonファイルからデータを抜き出す。
  // {"dates": ["2021-04-07 00:00:00.000","2021-04-13 00:00:00.000","2021-04-24 00:00:00.000","2021-04-28 00:00:00.000"]}
  // デコードするとこうなる
  // https://algorithm.joho.info/dart/object-string-json-dart/
  static const List<String> possibleDates = [
    "2021-04-07 00:00:00.000",
    "2021-04-13 00:00:00.000",
    "2021-04-24 00:00:00.000",
    "2021-04-28 00:00:00.000"
  ];

  //
  // サンプルのデータを表示する。
  // テーブルで表示して、参加可能日を選択する。
  // 選択結果のjsonをrailsへ送信する。
  // 送信中はloading画面を表示する。
  // 完了画面を表示する。
  //
  List<bool> selected =
      List<bool>.generate(possibleDates.length, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('候補日'),
              ),
              DataColumn(
                label: Text('○'),
              ),
              DataColumn(
                label: Text('△'),
              ),
              DataColumn(
                label: Text('☓'),
              ),
            ],
            rows: List<DataRow>.generate(
              possibleDates.length,
              (int index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(possibleDates[index])),
                  DataCell(Text('選択ボタンを表示')),
                  DataCell(Text('選択ボタンを表示')),
                  DataCell(Text('選択ボタンを表示')),
                ],
                // selected: selected[index],
                // onSelectChanged: (bool value) {
                //   setState(() {
                //     selected[index] = value;
                //   });
                // },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
