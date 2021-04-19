import 'package:flutter/material.dart';

import './hexcolor.dart';

class PossibleDatesTable extends StatefulWidget {
  @override
  _PossibleDatesTableState createState() => _PossibleDatesTableState();
}

class _PossibleDatesTableState extends State<PossibleDatesTable> {
  static const List<String> possibleDates = [
    "2021-04-07 00:00:00.000",
    "2021-04-13 00:00:00.000",
    "2021-04-24 00:00:00.000",
    "2021-04-28 00:00:00.000"
  ];

  Map<String, int> markedPossibleDates = {
    "2021-04-07 00:00:00.000": 1,
    "2021-04-13 00:00:00.000": 2,
    "2021-04-24 00:00:00.000": 3,
    "2021-04-28 00:00:00.000": 1,
  };

  List<bool> selected =
      List<bool>.generate(possibleDates.length, (int index) => false);

  // void _selectbutton(String mapKey, int pickNum) {
  //   markedPossibleDates[mapKey] = pickNum;
  //   print(markedPossibleDates);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor('EFE2DB'),
        borderRadius: BorderRadius.circular(18),
      ),
      child: DataTable(
        // headingRowColor:
        // MaterialStateColor.resolveWith((states) => Colors.blue),
        columns: const <DataColumn>[
          DataColumn(
            label: Text('候補日'),
          ),
          DataColumn(
            label: Center(
              child: Text(
                '🙆‍♀️',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: Text(
                '🤷‍♀️',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: Text(
                '🙅‍♀️',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        rows: List<DataRow>.generate(
          possibleDates.length,
          (int index) => DataRow(
            cells: <DataCell>[
              DataCell(Text(
                possibleDates[index],
                style: TextStyle(
                  color: Colors.green,
                ),
              )),
              DataCell(
                Center(
                  child: Text(
                    '🙆‍♀️',
                    // style: TextStyle(fontSize: 30.0),
                    style: (markedPossibleDates[possibleDates[index]] == 1)
                        ? TextStyle(fontSize: 30.0)
                        : TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[possibleDates[index]] = 1;
                    print(markedPossibleDates);
                  });
                  // _selectbutton(arg, 1);
                },
              ),
              DataCell(
                Center(
                  child: Text(
                    '🤷‍♀️',
                    style: (markedPossibleDates[possibleDates[index]] == 2)
                        ? TextStyle(fontSize: 30.0)
                        : TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[possibleDates[index]] = 2;
                    print(markedPossibleDates);
                  });
                },
              ),
              DataCell(
                Center(
                  child: Text(
                    '🙅‍♀️',
                    style: (markedPossibleDates[possibleDates[index]] == 3)
                        ? TextStyle(fontSize: 30.0)
                        : TextStyle(fontSize: 16.0),
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[possibleDates[index]] = 3;
                    print(markedPossibleDates);
                  });
                },
              ),
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
    );
  }
}
