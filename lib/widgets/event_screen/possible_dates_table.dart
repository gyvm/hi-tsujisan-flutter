// import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../common/hexcolor.dart';
import 'package:intl/intl.dart';

class PossibleDatesTable extends StatelessWidget {
  PossibleDatesTable(
      {Key? key,
      required this.possibleDates,
      this.guestData,
      this.guestPossibleDates,
      this.dateRate})
      : super(key: key);
  final List<dynamic> possibleDates;
  final List<dynamic>? guestData;
  final List<dynamic>? guestPossibleDates;
  final Map<dynamic, dynamic>? dateRate;
  // List<Map<String, dynamic>>? guestData;

  @override
  Widget build(BuildContext context) {
    // Map<String, int> markedPossibleDates = {
    //   "2021-06-02": 1,
    //   "2021-06-09": 0,
    //   "2021-06-16": 0,
    // };

    // guest[{id:1,possibletable:[{},{}]}]
    // guest[i][possibletable][1]

    print(possibleDates);
    print(guestData);

    // List<Map<String, dynamic>> guestData = [
    //   {
    //     "nickname": "dsews",
    //     "comment": "xwewcesdvscwec",
    //     "possible_dates": {"2021-06-02": 1, "2021-06-09": 1, "2021-06-16": 2},
    //   },
    //   {
    //     "nickname": "dsasdews",
    //     "comment": "xwewcescsdvcsdcwec",
    //     "possible_dates": {"2021-06-02": 1, "2021-06-09": 2, "2021-06-16": 3},
    //   },
    //   {
    //     "nickname": "dscdews",
    //     "comment": "xwewcecweczxecwec",
    //     "possible_dates": {"2021-06-02": 1, "2021-06-09": 3, "2021-06-16": 2},
    //   },
    //   {
    //     "nickname": "adsdsews",
    //     "comment": "xwewcescs sv rsfvdsdxcecwec",
    //     "possible_dates": {"2021-06-02": 1, "2021-06-09": 1, "2021-06-16": 3},
    //   }
    // ];
    // for (var key in markedPossibleDates.keys) {
    //   print('$key');
    //   print(markedPossibleDates['$key']);
    //   List<int>? art = markedPossibleDates['$key'];
    //   if (art[0] != 0) {
    //     print(art[0].toString());
    //   }
    // }

    // List<bool> selected =
    //     List<bool>.generate(possibleDates.length, (int index) => false);

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
              for (int i = 0; i < guestData!.length; i++)
                DataColumn(
                  label: Container(
                      width: 68,
                      child: Center(child: Text(guestData![i]['nickname']))),
                ),
              // DataColumn(
              //   label: Container(
              //       width: 68, child: Center(child: Text('testtest'))),
              // ),
              // DataColumn(
              //   label: Container(
              //       width: 68, child: Center(child: Text('testtest'))),
              // ),
              // DataColumn(
              //   label: Container(
              //       width: 68, child: Center(child: Text('testtest'))),
              // ),
              // DataColumn(
              //   label: Container(
              //       width: 68, child: Center(child: Text('testtest'))),
              // ),

              // DataColumn(
              //   label: Center(child: Text('コメント')),
              // ),
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
                    (dateRate!.containsKey(possibleDates[i]["id"]))
                        ? DataCell(Center(
                            child: Text(
                              dateRate![possibleDates[i]["id"]].toString() +
                                  '人',
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                        : DataCell(Text('0人')),
                    // _getGuestStatus(i),
                    DataCell(
                      Container(child: Text('bbbbbbbb')),
                    ),
                  ],
                ),
              // 参加者ごとのコメント
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('コメント')),
                  DataCell(Text('')),
                  for (int i = 0; i < guestData!.length; i++)
                    DataCell(
                      Container(
                          width: 68, child: Text(guestData![i]['comment'])),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _verticalDivider = const VerticalDivider(
  //   color: Colors.black,
  //   thickness: 1,
  // );

  DataCell _getGuestStatus(i) {
    return DataCell(
      Container(child: Text('bbbbbbbb')),
    );
    // List<Widget> list;
    // for (int j = 0; j < guestData!.length; j++)
    //                   // DataCell(Text(
    //                   //     guestData[i]['possible_dates']['$key'].toString())),
    //                   for (int k = 0; k < guestPossibleDates!.length; k++)
    //                     (guestData![j]["id"] ==
    //                             guestPossibleDates![k]["guest_id"])
    //                         ? (possibleDates![i]["id"] ==
    //                                 guestPossibleDates![k]["date"])
    //                             ? DataCell(
    //                                 Center(
    //                                   child: _switchIcon(guestPossibleDates![k]
    //                                           ['status']
    //                                       .toString()),
    //                                 ),
    //                               )
    //                             : continue;
    //                         : continue;
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
}
