import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';
import '../../model/guest_model.dart';
import '../../common/hexcolor.dart';
import '../../screens/event_screen.dart';

import '../../main.dart';

submitPossibleDates(
    {required BuildContext context,
    required String url,
    required String nickname,
    required String comment,
    required Map<String, int> markedPossibleDates}) async {
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

  print(response.statusCode);
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => EventScreen(url: url)));
    Navigator.pushNamed(
      context,
      EventScreen.routeName,
      arguments: EventScreenArguments(url),
    );
    // final pagePath = '/event' + url.toString();
    // Navigator.pushNamed(context, pagePath);
  } else {
    throw Exception('Failed to add guestdata.');
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
  @override
  Widget build(BuildContext context) {
    return Consumer<GuestModel>(builder: (context, guest, child) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 50),
          child: SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              child: Text('送信'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                primary: HexColor('#8A5C46'),
              ),
              onPressed: () {
                submitPossibleDates(
                    context: context,
                    url: widget.url,
                    nickname: guest.nickname,
                    comment: guest.comment,
                    markedPossibleDates: guest.markedPossibleDates);
              },
            ),
          ),
        ),
      );
    });
  }
}
