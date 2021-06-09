// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class PossibleDatesTable extends StatelessWidget {
  PossibleDatesTable({Key? key, required this.possibleDates}) : super(key: key);
  final List<dynamic> possibleDates;

  @override
  Widget build(BuildContext context) {
    Map<String, int> markedPossibleDates = {
      "2021-06-02": 1,
      "2021-06-09": 0,
      "2021-06-16": 0,
    };

    List<Map<String, dynamic>> guestData = [
      {
        "nickname": "dsews",
        "comment": "xwewcesdvscwec",
        "possible_dates": {"2021-06-02": 1, "2021-06-09": 1, "2021-06-16": 2},
      },
      {
        "nickname": "dsasdews",
        "comment": "xwewcescsdvcsdcwec",
        "possible_dates": {"2021-06-02": 1, "2021-06-09": 2, "2021-06-16": 3},
      },
      {
        "nickname": "dscdews",
        "comment": "xwewcecweczxecwec",
        "possible_dates": {"2021-06-02": 1, "2021-06-09": 3, "2021-06-16": 2},
      },
      {
        "nickname": "adsdsews",
        "comment": "xwewcescs sv rsfvdsdxcecwec",
        "possible_dates": {"2021-06-02": 1, "2021-06-09": 1, "2021-06-16": 3},
      }
    ];
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
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DataTable(
        showBottomBorder: true,
        // headingRowHeight: 0,
        // headingRowColor:
        //     MaterialStateColor.resolveWith((states) => Colors.blue),
        columns: <DataColumn>[
          DataColumn(
            label: Center(child: Text('日にち')),
          ),
          DataColumn(
            label: Center(
                child: Icon(
              Icons.circle,
            )),
          ),
          for (int i = 0; i < guestData.length; i++)
            DataColumn(
              label: Center(child: Text(guestData[i]['nickname'])),
            ),
          // DataColumn(
          //   label: Center(child: Text('コメント')),
          // ),
        ],

        rows: [
          for (var key in markedPossibleDates.keys)
            DataRow(
              cells: <DataCell>[
                DataCell(Text('$key')),
                (markedPossibleDates['$key'] != null)
                    ? DataCell(Text(markedPossibleDates['$key'].toString()))
                    : DataCell(Text('null')),
                for (int i = 0; i < guestData.length; i++)
                  DataCell(
                      Text(guestData[i]['possible_dates']['$key'].toString())),
              ],
            ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('コメント')),
              DataCell(Text('')),
              for (int i = 0; i < guestData.length; i++)
                DataCell(Text(guestData[i]['comment'])),
            ],
          ),
        ],
      ),
    );
  }
}
