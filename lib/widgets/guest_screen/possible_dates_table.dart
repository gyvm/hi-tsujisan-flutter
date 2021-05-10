import 'package:flutter/material.dart';

import '../../common/h2text.dart';
import '../../common/hexcolor.dart';

import 'package:intl/intl.dart';

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
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
        decoration: BoxDecoration(
          color: HexColor('#F4EFED'),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            H2Text(text: '参加可能日を教えて下さい！'),
            _tableContainer(),
          ],
        ),
      ),
    );
  }

  Widget _tableContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DataTable(
        showBottomBorder: true,
        headingRowHeight: 0,
        // headingRowColor:
        //     MaterialStateColor.resolveWith((states) => Colors.blue),
        columns: const <DataColumn>[
          DataColumn(
            label: Center(),
          ),
          DataColumn(
            label: Center(),
          ),
          DataColumn(
            label: Center(),
          ),
          DataColumn(
            label: Center(),
          ),
        ],
        rows: List<DataRow>.generate(
          possibleDates.length,
          (int index) => DataRow(
            cells: <DataCell>[
              DataCell(Text(
                // possibleDates[index],
                // DateFormat('y年M月d日')
                //     .format(DateTime.parse(possibleDates[index])),
                DateFormat('M月d日').format(DateTime.parse(possibleDates[index])),
                style: TextStyle(),
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

// (new) DataTable DataTable({Key? key, required List<DataColumn> columns, int? sortColumnIndex, bool sortAscending = true, void Function(bool?)? onSelectAll, Decoration? decoration, MaterialStateProperty<Color?>? dataRowColor, double? dataRowHeight, TextStyle? dataTextStyle, MaterialStateProperty<Color?>? headingRowColor, double? headingRowHeight, TextStyle? headingTextStyle, double? horizontalMargin, double? columnSpacing, bool showCheckboxColumn = true, bool showBottomBorder = false, double? dividerThickness, required List<DataRow> rows})
