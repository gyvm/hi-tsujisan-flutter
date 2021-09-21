// import 'dart:ffi';

// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import '../../common/hexcolor.dart';

class PossibleDatesTable extends StatelessWidget {
  PossibleDatesTable(
      {Key key,
      this.possibleDates,
      this.guestData,
      this.guestPossibleDates,
      this.dateRate})
      : super(key: key);
  final List<dynamic> possibleDates;
  final List<dynamic> guestData;
  final List<dynamic> guestPossibleDates;
  final Map<dynamic, dynamic> dateRate;
  // List<Map<String, dynamic>>? guestData;

  int tableWidth = 720;

  @override
  Widget build(BuildContext context) {
    print('guestData.length: ' + guestData.length.toString());
    print('dateRate: ');
    print(dateRate);

    return Container(
      decoration: BoxDecoration(
        // color: Colors.transparent,
        color: HexColor('#F4EFED'),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 720,
          // minHeight: 0,
          maxWidth: 720,
          maxHeight: double.infinity,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            // columnSpacing: 10,
            // headingRowHeight: 0,
            headingRowColor: MaterialStateColor.resolveWith(
              (states) => HexColor('#EFE2DB'),
            ),
            // 横の項目名
            columns: <DataColumn>[
              DataColumn(
                label: Center(child: Container(width: 50, child: Text('日にち'))),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 10,
                    child: Icon(
                      Icons.thumb_up_outlined,
                      color: HexColor('#8A5C46'),
                      size: 24.0,
                      semanticLabel: '参加可能',
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < guestData.length; i++)
                DataColumn(
                    label: Container(
                        width: 68,
                        child: Center(
                            child: (guestData[i]['nickname'] != null) ||
                                    (guestData[i]['nickname'] <= 0)
                                ? Text(guestData[i]['nickname'])
                                : Text('未入力')))),
              _fillColumnMargin(guestData.length)
            ],

            rows: [
              for (int i = 0; i < possibleDates.length; i++)
                DataRow(
                  cells: <DataCell>[
                    // 日付を表示
                    DataCell(
                      Text(
                        DateFormat('M月d日').format(
                          DateTime.parse(possibleDates[i]["date"]),
                        ),
                      ),
                    ),
                    // 参加可能人数
                    (dateRate.containsKey(possibleDates[i]['id'].toString()))
                        ? DataCell(Center(
                            child: Text(
                              dateRate[possibleDates[i]['id'].toString()]
                                      .toString() +
                                  '人',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                        : DataCell(Text('0人')),

                    for (int j = 0; j < guestData.length; j++)
                      // DataCell(Center(child: Text('GOOD'))),
                      _getGuestStatus(i, j),

                    _fillCellMargin(guestData.length)
                  ],
                ),
              // 参加者ごとのコメント
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('コメント')),
                  DataCell(Text('')),
                  for (int j = 0; j < guestData.length; j++)
                    DataCell(
                      Container(
                        width: 68,
                        child: Center(
                            child: (guestData[j]['comment'] != null)
                                ? Text(guestData[j]['comment'])
                                : Text('')),
                      ),
                    ),
                  _fillCellMargin(guestData.length)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataCell _getGuestStatus(i, j) {
    for (int k = 0; k < guestPossibleDates.length; k++) {
      if ((possibleDates[i]['id'] == guestPossibleDates[k]['date']) &&
          (guestData[j]['id'] == guestPossibleDates[k]['guest_id'])) {
        return DataCell(Center(
            child: _switchIcon(guestPossibleDates[k]['status'].toString())));
      }
    }
    return DataCell(Center(child: Text('未入力')));
  }

  Widget _switchIcon(value) {
    switch (value) {
      case '1':
        return Center(
          child: Icon(
            Icons.thumb_up_outlined,
            color: HexColor('#8A5C46'),
            size: 20.0,
            semanticLabel: '参加可能',
          ),
        );
      case '2':
        return Center(
          child: Icon(
            Icons.sentiment_neutral_outlined,
            color: Colors.grey,
            size: 20.0,
            semanticLabel: '参加可能',
          ),
        );
      case '3':
        return Center(
          child: Icon(
            Icons.thumb_down_outlined,
            color: Colors.grey,
            size: 20.0,
            semanticLabel: '参加できない',
          ),
        );
      default:
        return Center();
    }
  }

  DataColumn _fillColumnMargin(value) {
    var _margens = (tableWidth - 64 - 50) - ((guestData.length + 1) * 68);
    print('_margens: ' + _margens.toString());
    if (_margens > 0) {
      return DataColumn(
        label: Container(width: _margens.toDouble()),
      );
    }
    return DataColumn(
      label: Container(width: 0),
    );
  }

  DataCell _fillCellMargin(value) {
    return DataCell(
      Container(),
    );
  }
}
