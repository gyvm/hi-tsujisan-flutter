// Flutter imports:
import 'package:flutter/material.dart';

class GuestModel extends ChangeNotifier {
  String url = '';
  String nickname = '';
  String comment = '';
  List<Map<String, dynamic>> possibleDates = [{}];
  Map<String, int> markedPossibleDates = {};
}
