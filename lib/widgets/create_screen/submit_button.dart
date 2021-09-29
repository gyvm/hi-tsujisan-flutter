// Dart imports:
import 'dart:convert';
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import "package:intl/intl.dart";
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../common/hexcolor.dart';
import '../../model/event_model.dart';
import '../../page_state.dart';

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

  DateFormat format = DateFormat('yyyy-MM-dd');
  for (int i = 0; i < selectedDates.length; i++) {
    possibleDates.add(format.format(selectedDates[i]).toString());
  }
  possibleDates.sort((a, b) => a.compareTo(b));

  final client = RetryClient(http.Client(),
      retries: 5,
      when: (response) =>
          ((response.statusCode == 502) || (response.statusCode == 503)),
      whenError: (dynamic error, StackTrace stackTrace) {
        print(stackTrace);
        return true;
      },
      onRetry: (http.BaseRequest request, http.BaseResponse response,
              int retryCount) =>
          print("retry!"));

  final response = await client.post(
    Uri.https('hi-tsujisan.com', '/api/v1/events'),
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
  try {
    if (response.statusCode == 200) {
      onTapped(
        PageState(
            eventId: EventResponse.fromJson(jsonDecode(response.body)).url,
            pageName: 'event',
            isUnknown: false),
      );
    } else {
      onTapped(PageState(eventId: null, pageName: null, isUnknown: false));
      // throw Exception('イベントの作成に失敗したためページをリロードしてください');
    }
  } finally {
    client.close();
  }
}

class SubmitButton extends StatefulWidget {
  final ValueChanged<PageState> onTapped;
  SubmitButton({this.onTapped});

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool inputAlarm = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(builder: (context, event, child) {
      return Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 50),
            child: Column(
              children: [
                if (inputAlarm)
                  Text(
                    'イベント名、候補日を入力してください。',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                SizedBox(
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
                        if ((event.eventName != null) &&
                            (event.selectedDates != null)) {
                          if ((event.eventName.length > 0) &&
                              (event.selectedDates.length > 0)) {
                            createEvent(
                                context: context,
                                name: event.eventName,
                                description: event.eventDescription,
                                selectedDates: event.selectedDates,
                                onTapped: widget.onTapped);
                          } else {
                            setState(() {
                              inputAlarm = true;
                            });
                          }
                        } else {
                          setState(() {
                            inputAlarm = true;
                          });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
