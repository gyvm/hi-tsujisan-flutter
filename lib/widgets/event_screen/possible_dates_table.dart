import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PossibleDatesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // const List<String> possibleDates = [
    //   "2021-04-07 00:00:00.000",
    //   "2021-04-13 00:00:00.000",
    //   "2021-04-24 00:00:00.000",
    //   "2021-04-28 00:00:00.000"
    // ];

    const List<String> possibleDates = [
      "2021-05-03",
      "2021-05-10",
      "2021-05-24"
    ];

    Map<String, int> markedPossibleDates = {
      "2021-04-07 00:00:00.000": 1,
      "2021-04-13 00:00:00.000": 2,
      "2021-04-24 00:00:00.000": 3,
      "2021-04-28 00:00:00.000": 1,
    };

    List<bool> selected =
        List<bool>.generate(possibleDates.length, (int index) => false);
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
          DataColumn(
            label: Center(
                child: Icon(
              Icons.change_history_outlined,
            )),
          ),
          DataColumn(
            label: Center(
                child: Icon(
              Icons.close_outlined,
            )),
          ),
          // for (var i in text) Text(i.toString())m
          for (var i in possibleDates)
            DataColumn(
              label: Center(
                  child: Icon(
                Icons.close_outlined,
              )),
            ),
        ],

        rows: [
          DataRow(
            cells: <DataCell>[
              DataCell(Text('aaaa')),
              DataCell(Text('aaaa')),
              DataCell(Text('aaaa')),
              DataCell(Text('aaaa')),
              for (var i in (possibleDates)) DataCell(Text('aaaa')),
            ],
          ),
        ],

        // rows: List<DataRow>.generate(
        //   possibleDates.length,
        //   (int index) => DataRow(
        //     cells: <DataCell>[
        // DataCell(Text(
        //   // possibleDates[index],
        //   // DateFormat('y年M月d日')
        //   //     .format(DateTime.parse(possibleDates[index])),
        //   DateFormat('M月d日').format(DateTime.parse(possibleDates[index])),
        //   style: TextStyle(),
        // )),
        // DataCell(
        //   Center(
        //     child: Text(
        //       '🙆‍♀️',
        //       // style: TextStyle(fontSize: 30.0),
        //       style: (markedPossibleDates[possibleDates[index]] == 1)
        //           ? TextStyle(fontSize: 30.0)
        //           : TextStyle(fontSize: 16.0),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        //   onTap: () {
        //     // _selectbutton(arg, 1);
        //   },
        // ),
        // DataCell(
        //   Center(
        //     child: Text(
        //       '🤷‍♀️',
        //       style: (markedPossibleDates[possibleDates[index]] == 2)
        //           ? TextStyle(fontSize: 30.0)
        //           : TextStyle(fontSize: 16.0),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        //   onTap: () {},
        // ),
        // DataCell(
        //   Center(
        //     child: Text(
        //       '🙅‍♀️',
        //       style: (markedPossibleDates[possibleDates[index]] == 3)
        //           ? TextStyle(fontSize: 30.0)
        //           : TextStyle(fontSize: 16.0),
        //     ),
        //   ),
        //   onTap: () {},
        // ),
        // ],
        // selected: selected[index],
        // onSelectChanged: (bool value) {
        //   setState(() {
        //     selected[index] = value;
        //   });
        // },
      ),
    );
    //   ),
    // );
  }
}
