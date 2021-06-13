import 'package:flutter/material.dart';

class EventModel extends ChangeNotifier {
  List<dynamic> selectedDates = [];
  String eventName = '';
  String eventDescription = '';
}
