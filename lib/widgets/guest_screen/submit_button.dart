import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Event> submitPossibleDates() async {
  String url = 'VoEaT2JShD1620260925';
  String nickname = 'yosuke03';
  String comment = 'いつでもOKです！';
  Map<String, int> possibleDates = {
    "2021-05-08": 1,
    "2021-05-12": 2,
    "2021-05-13": 3,
    "2021-05-18": 3,
    "2021-05-20": 1
  };

  print(
    jsonEncode(<String, dynamic>{
      "url": url,
      "nickname": nickname,
      "comment": comment,
      "possible_dates": possibleDates,
    }),
  );

  final response = await http.post(
    Uri.http('localhost:3000', '/api/v1/guests'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "url": url,
      "nickname": nickname,
      "comment": comment,
      "possible_dates": possibleDates,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Event.');
  }
}

class Event {
  final String? status;
  final event;

  Event({this.status, this.event});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      status: json['status'],
      event: json['event'],
    );
  }
}

class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  Future<Event>? _futureEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (_futureEvent == null)
          ? Container(
              child: ElevatedButton(
                child: Text('送信'),
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  _futureEvent = submitPossibleDates();
                },
              ),
            )
          : FutureBuilder<Event>(
              future: _futureEvent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('SUCCESS');
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
    );
  }
}
