import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';
import '../../model/guest_model.dart';

Future<Event> submitPossibleDates(
    {required BuildContext context,
    required String url,
    required String nickname,
    required String comment,
    required Map<String, int> markedPossibleDates}) async {
  print(
    jsonEncode(<String, dynamic>{
      "url": url,
      "nickname": nickname,
      "comment": comment,
      "possible_dates": markedPossibleDates,
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
      "possible_dates": markedPossibleDates,
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

class GuestsSubmitButton extends StatefulWidget {
  final String url;
  GuestsSubmitButton({required this.url});

  @override
  _GuestsSubmitButtonState createState() => _GuestsSubmitButtonState();
}

class _GuestsSubmitButtonState extends State<GuestsSubmitButton> {
  Future<Event>? _futureEvent;

  @override
  Widget build(BuildContext context) {
    return Consumer<GuestModel>(builder: (context, guest, child) {
      return Container(
        child: (_futureEvent == null)
            ? Container(
                child: ElevatedButton(
                  child: Text('送信'),
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    _futureEvent = submitPossibleDates(
                        context: context,
                        url: widget.url,
                        nickname: guest.nickname,
                        comment: guest.comment,
                        markedPossibleDates: guest.markedPossibleDates);
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
