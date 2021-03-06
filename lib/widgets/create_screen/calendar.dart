// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../common/h2text.dart';
import '../../common/hexcolor.dart';
import '../../model/event_model.dart';

class CalendarContainer extends StatefulWidget {
  @override
  _CalendarContainerState createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, bottom: 0, top: 32, right: 32),
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          // color: HexColor('#F4EFED'),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: H2Text(text: '候補日を選択してください'),
            ),
            Calendar(
              itemHeight: 45.0,
              weekDay: 7, // 日曜日から順に表示するように指定
              color: HexColor('#8A5C46'),
            ),
          ],
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  final double itemHeight;
  final int weekDay;
  final Color color;

  Calendar({
    this.itemHeight = 45.0,
    this.weekDay = 7,
    this.color = Colors.blue,
  }) : super();

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate;
  DateTime now = DateTime.now();
  DateTime today = DateTime.now();
  int monthDuration = 0;

  List<DateTime> selectedDatesListForView = [];

  @override
  void initState() {
    super.initState();

    selectedDate = now;
  }

  @override
  Widget build(BuildContext context) {
    return buildCalendar();
  }

  Widget buildCalendar() {
    List<Widget> _list = [];

    // 年、月を表示
    _list.add(
      Container(
        height: widget.itemHeight,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(
                  Icons.chevron_left_outlined,
                  // size: widget.itemHeight,
                  size: 30,
                ),
                onTap: () {
                  monthDuration--;
                  setState(() {});
                },
              ),
            ),
            Text(
              DateFormat('yyyy年M月')
                  .format(DateTime(now.year, now.month + monthDuration, 1)),
              style: TextStyle(fontSize: 18.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                child: Icon(
                  Icons.chevron_right_outlined,
                  // size: widget.itemHeight,
                  size: 30,
                ),
                onTap: () {
                  monthDuration++;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );

    // 曜日を表示
    List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
    List<Widget> _weekList = [];
    int _weekIndex = widget.weekDay - 1;
    int _counter = 0;
    while (_counter < 7) {
      _weekList.add(Expanded(
        child: Container(
          child: Text(
            _weekName[_weekIndex % 7],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ));
      _weekIndex++;
      _counter++;
    }
    _list.add(
      Row(
        children: _weekList,
      ),
    );

    // 日の表示
    DateTime _now = DateTime(now.year, now.month + monthDuration, 1);
    int monthLastNumber =
        DateTime(_now.year, _now.month + 1, 1).add(Duration(days: -1)).day;
    List<Widget> _listCache = [];
    for (int i = 1; i <= monthLastNumber; i++) {
      _listCache.add(Expanded(
        child: buildCalendarItem(i, DateTime(_now.year, _now.month, i)),
      ));

      if (DateTime(_now.year, _now.month, i).weekday ==
              newLineNumber(startNumber: widget.weekDay) ||
          i == monthLastNumber) {
        int repeatNumber = 7 - _listCache.length;
        for (int j = 0; j < repeatNumber; j++) {
          if (DateTime(_now.year, _now.month, i).day <= 7) {
            _listCache.insert(
                0,
                Expanded(
                  child: Container(height: widget.itemHeight),
                ));
          } else {
            _listCache.add(Expanded(
              child: Container(
                height: widget.itemHeight,
              ),
            ));
          }
        }

        _list.add(Row(
          children: _listCache,
        ));
        _listCache = [];
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: _list,
      ),
    );
  }

  int newLineNumber({int startNumber}) {
    if (startNumber == 1) return 7;
    return startNumber - 1;
  }

  Widget buildCalendarItem(int i, DateTime cacheDate) {
    bool isSelected = selectedDatesListForView.contains(cacheDate);
    if (isSelected) {
      return CircleAvatar(
        radius: 18,
        backgroundColor: widget.color,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.center,
            height: widget.itemHeight,
            child: Text(
              '$i',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            setState(
              () {
                selectedDatesListForView.forEach((date) {
                  if (date == cacheDate) selectedDate = cacheDate;
                });
                selectedDatesListForView.remove(selectedDate);
              },
            );
            var event = context.read<EventModel>();
            event.selectedDates.remove(selectedDate);
          },
        ),
      );
    }

    int diffDays = cacheDate.difference(today).inDays;
    bool isBefore = (diffDays < 0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        height: widget.itemHeight,
        child: Text(
          '$i',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: (isBefore) ? Colors.grey : Colors.black,
          ),
        ),
      ),
      onTap: (isBefore)
          ? null
          : () {
              setState(() {
                selectedDatesListForView.add(cacheDate);
              });
              var event = context.read<EventModel>();
              event.selectedDates.add(cacheDate);
            },
    );
  }
}
