// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Project imports:
import '../../common/hexcolor.dart';
import '../../main.dart';
import '../../model/guest_model.dart';
import '../../page_state.dart';
import '../../screens/details_screen.dart';

submitPossibleDates(
    {@required String url,
    @required String nickname,
    String comment,
    @required Map<String, int> markedPossibleDates,
    @required onTapped}) async {
  final response = await http.post(
    Uri.http('localhost:3000', '/api/v1/guests'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "url": url,
      "guest": {
        "nickname": nickname,
        "comment": comment,
        "possible_dates": markedPossibleDates,
      }
    }),
  );

  if (response.statusCode == 200) {
    onTapped(
      PageState(eventId: url, pageName: 'event', isUnknown: false),
    );
  } else {
    throw Exception('データの登録に失敗しました。ページをリロードしてください。');
  }
}

class Event {
  final String status;
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
  final ValueChanged<PageState> onTapped;
  GuestsSubmitButton({this.url, @required this.onTapped});

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
                    url: widget.url,
                    nickname: guest.nickname,
                    comment: guest.comment,
                    markedPossibleDates: guest.markedPossibleDates,
                    onTapped: widget.onTapped);
              },
            ),
          ),
        ),
      );
    });
  }
}
