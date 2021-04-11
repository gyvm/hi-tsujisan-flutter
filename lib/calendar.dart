import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Calendar extends StatefulWidget {
  Calendar({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2021, 4, 11);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2021, 4, 11));
  DateTime _targetDateTime = DateTime(2021, 4, 11);
  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        DateTime(2019, 2, 25),
        Event(
          date: DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        DateTime(2019, 2, 10),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(DateTime(2019, 2, 11), [
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
        _markedDateMap.add(
          DateTime(2019, 3, 3),
          Event(
            date: DateTime(2019, 3, 3),
            title: 'Selected',
            icon: _eventIcon,
          ),
        );
        // DateTime now = DateTime.now();
        // List<int> today = [];
        // today.add(int.parse(DateFormat.y().format(now)));
        // today.add(int.parse(DateFormat.m().format(now)));
        // today.add(int.parse(DateFormat.d().format(now)));
        // print(today);
        // print(DateTime.now().toString());
        // print(DateFormat.y().format(now).toString());
      },

      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      // headerText: 'Custom Header',
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 500.0,
      selectedDateTime: _currentDate,
      showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon ?? Icon(Icons.help_outline);
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
      selectedDayBorderColor: Colors.red,
      selectedDayButtonColor: Colors.red,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
    );

    return Container(
      constraints: BoxConstraints(
        // minHeight: 10.0,
        maxWidth: 500.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //custom icon
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarousel,
            ),
          ],
        ),
      ),
    );
  }
}
