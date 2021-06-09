import 'package:flutter/material.dart';

class GuestModel extends ChangeNotifier {
  String url = '';
  String nickname = '';
  String comment = '';
  Map<String, int> possibleDates = {};
  Map<String, int> markedPossibleDates = {};
}
