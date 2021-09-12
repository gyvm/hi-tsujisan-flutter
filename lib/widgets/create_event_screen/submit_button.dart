import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import "package:intl/intl.dart";
// import 'dart:async';
import 'dart:convert';

import '../../common/hexcolor.dart';
import '../../model/event_model.dart';
import '../../screens/event_screen.dart';

import '../../main.dart';

class EventResponse {
  final String status;
  final String url;

  EventResponse({this.status, this.url});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      status: json['status'],
      url: json['url'],
    );
  }
}

createEvent(
    {BuildContext context,
    String name,
    String description,
    List<DateTime> selectedDates}) async {
  // print(selectedDates);
  List<String> possibleDates = [];
  for (int i = 0; i < selectedDates.length; i++) {
    possibleDates
        .add(DateFormat('yyyy-MM-dd').format(selectedDates[i]).toString());
    // print(possibleDates);
  }

  final response = await http.post(
    Uri.http('localhost:3000', '/api/v1/events'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "event": {
        "name": name,
        "description": description,
        "possible_dates": possibleDates,
      }
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => EventScreen(
    //             url: EventResponse.fromJson(jsonDecode(response.body)).url)));
    Navigator.pushNamed(
      context,
      EventScreen.routeName,
      arguments: EventScreenArguments(
          EventResponse.fromJson(jsonDecode(response.body)).url.toString()),
    );
  } else {
    throw Exception('Failed to create event.');
  }
}

class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(builder: (context, event, child) {
      return Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 50),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  'イベントを作成する',
                  style: TextStyle(
                    fontSize: 18,
                    color: HexColor('#F4EFED'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  primary: HexColor('#8A5C46'),
                ),
                onPressed: () {
                  createEvent(
                      context: context,
                      name: event.eventName,
                      description: event.eventDescription,
                      selectedDates: event.selectedDates);
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
