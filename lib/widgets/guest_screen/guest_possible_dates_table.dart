// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../common/h2text.dart';
import '../../common/hexcolor.dart';
import '../../model/guest_model.dart';

class PossibleDatesTable extends StatefulWidget {
  // final List<dynamic> possibleDates;
  final List<dynamic> possibleDates;
  PossibleDatesTable({
    this.possibleDates,
  });

  @override
  _PossibleDatesTableState createState() => _PossibleDatesTableState();
}

class _PossibleDatesTableState extends State<PossibleDatesTable> {
  Map<String, int> markedPossibleDates = {};

  @override
  Widget build(BuildContext context) {
    widget.possibleDates.sort((a, b) => a['date'].compareTo(b['date']));
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: H2Text(text: '参加可能日を教えて下さい！'),
            ),
            _tableContainer(),
          ],
        ),
      ),
    );
  }

  Widget _tableContainer() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor('#F4EFED'),
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
          widget.possibleDates.length,
          (int index) => DataRow(
            cells: <DataCell>[
              DataCell(Text(
                // possibleDates[index],
                // DateFormat('y年M月d日')
                //     .format(DateTime.parse(possibleDates[index])),
                DateFormat('M月d日').format(
                    DateTime.parse(widget.possibleDates[index]['date'])),
                style: TextStyle(),
              )),
              DataCell(
                Center(
                  child: Icon(
                    Icons.thumb_up_outlined,
                    color: (markedPossibleDates[
                                widget.possibleDates[index]['id'].toString()] ==
                            1)
                        ? HexColor('#8A5C46')
                        : Colors.grey,
                    size: 28.0,
                    semanticLabel: '参加可能',
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 1;
                    var guest = context.read<GuestModel>();
                    guest.markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 1;
                  });
                  // _selectbutton(arg, 1);
                },
              ),
              DataCell(
                Center(
                  child: Icon(
                    Icons.sentiment_neutral_outlined,
                    color: (markedPossibleDates[
                                widget.possibleDates[index]['id'].toString()] ==
                            2)
                        ? HexColor('#8A5C46')
                        : Colors.grey,
                    size: 28.0,
                    semanticLabel: '考え中',
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 2;
                    var guest = context.read<GuestModel>();
                    guest.markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 2;
                  });
                },
              ),
              DataCell(
                Center(
                  child: Icon(
                    Icons.thumb_down_outlined,
                    color: (markedPossibleDates[
                                widget.possibleDates[index]['id'].toString()] ==
                            3)
                        ? HexColor('#8A5C46')
                        : Colors.grey,
                    size: 28.0,
                    semanticLabel: '参加できない',
                  ),
                ),
                onTap: () {
                  setState(() {
                    markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 3;
                    var guest = context.read<GuestModel>();
                    guest.markedPossibleDates[
                        widget.possibleDates[index]['id'].toString()] = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
