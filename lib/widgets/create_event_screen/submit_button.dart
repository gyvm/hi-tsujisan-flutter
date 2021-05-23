import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import "package:intl/intl.dart";

import '../../model/event_model.dart';

Future<Event> createEvent(
    {required String name,
    required String description,
    required List<dynamic> selectedDates}) async {
  for (int i = 0; i < selectedDates.length; i++) {
    print(selectedDates[i]);
    selectedDates[i] = DateFormat('yyyy-MM-dd').format(selectedDates[i]);
  }

  Map<String, List<dynamic>> possibleDates = {'possible_dates': selectedDates};

  // String description = 'aaaa';
  // Map<String, List<dynamic>> possibleDates = {
  //   'possible_dates': [
  //     "2021-04-25",
  //     "2021-04-27",
  //     "2021-04-29",
  //     "2021-05-02",
  //     "2021-05-08"
  //   ]
  // };

  print(name);
  print(description);
  print(possibleDates);
  print('start encord');
  print(
    jsonEncode(<String, dynamic>{
      "name": name,
      "description": description,
      "possible_dates": possibleDates,
    }),
  );
  print('end encord');

  final response = await http.post(
    Uri.http('localhost:3000', '/api/v1/events'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": name,
      "description": description,
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
    return Consumer<EventModel>(builder: (context, event, child) {
      return Container(
        child: (_futureEvent == null)
            ? Container(
                child: ElevatedButton(
                  child: Text('イベント調整を開始する'),
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    setState(() {
                      _futureEvent = createEvent(
                          name: event.eventName,
                          description: event.eventDescription,
                          selectedDates: event.selectedDates);
                    });
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
    });
  }
}
