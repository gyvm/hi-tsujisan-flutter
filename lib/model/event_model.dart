import 'package:flutter/material.dart';

class EventModel extends ChangeNotifier {
  List<DateTime> selectedDates = [];
  String eventName = '';
  String eventDescription = '';
}
