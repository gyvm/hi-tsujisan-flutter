import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import "package:intl/intl.dart";
import 'dart:async';
import 'dart:convert';

import '../../common/hexcolor.dart';
import '../../model/event_model.dart';
import '../../screens/event_screen.dart';

Future<Event> createEvent(
    {required BuildContext context,
    required String name,
    required String description,
    required List<dynamic> selectedDates}) async {
  for (int i = 0; i < selectedDates.length; i++) {
    print(selectedDates[i]);
    selectedDates[i] = DateFormat('yyyy-MM-dd').format(selectedDates[i]);
  }

  Map<String, List<dynamic>> possibleDates = {'possible_dates': selectedDates};
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
  final String status;
  final event;
  final String url;

  Event({required this.status, this.event, required this.url});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      status: json['status'],
      event: json['event'],
      url: json['url'],
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 50),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        'イベント調整を開始する',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
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
                        setState(() {
                          _futureEvent = createEvent(
                              context: context,
                              name: event.eventName,
                              description: event.eventDescription,
                              selectedDates: event.selectedDates);
                        });
                      },
                    ),
                  ),
                ),
              )
            : FutureBuilder<Event>(
                future: _futureEvent,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // if (snapshot.hasData) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               EventScreen(url: snapshot.data!.url)));
                  // }
                  // Navigator.pushNamed(context, '/event', arguments: 'url');
                  // print(Event.);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EventScreen(url: snapshot.data!.url)));
                  return CircularProgressIndicator();
                }),
      );
    });
  }
}
