// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import "package:intl/intl.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Project imports:
import '../../common/hexcolor.dart';
import '../../main.dart';
import '../../model/event_model.dart';
import '../../page_state.dart';
import '../../screens/details_screen.dart';

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
    @required String name,
    String description,
    @required List<DateTime> selectedDates,
    @required ValueChanged<PageState> onTapped}) async {
  List<String> possibleDates = [];
  for (int i = 0; i < selectedDates.length; i++) {
    possibleDates
        .add(DateFormat('yyyy-MM-dd').format(selectedDates[i]).toString());
  }

  final response = await http.post(
    Uri.http('hi-tsujisan.com', '/api/v1/events'),
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
    onTapped(
      PageState(
          eventId: EventResponse.fromJson(jsonDecode(response.body)).url,
          pageName: 'event',
          isUnknown: false),
    );
  } else {
    throw Exception('イベントの作成に失敗しました。ページをリロードしてください。');
  }
}

class SubmitButton extends StatefulWidget {
  final ValueChanged<PageState> onTapped;
  SubmitButton({this.onTapped});

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
                      selectedDates: event.selectedDates,
                      onTapped: widget.onTapped);
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
