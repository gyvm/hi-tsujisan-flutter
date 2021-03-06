// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../common/hexcolor.dart';
import '../../model/guest_model.dart';
import '../../page_state.dart';

submitPossibleDates(
    {@required String url,
    @required String nickname,
    String comment,
    @required Map<String, int> markedPossibleDates,
    @required onTapped}) async {
  if (nickname != null) {
    if (nickname.length <= 0) {
      nickname = '(未入力)';
    }
  } else if (nickname == null) {
    nickname = '(未入力)';
  }

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
    Uri.https('hi-tsujisan.com', '/api/v1/guests'),
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
  try {
    if (response.statusCode == 200) {
      onTapped(
        PageState(eventId: url, pageName: 'event', isUnknown: false),
      );
    } else {
      onTapped(PageState(eventId: null, pageName: null, isUnknown: false));
      throw Exception('データの登録に失敗したためページをリロードしてください');
    }
  } finally {
    client.close();
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
  // ignore: non_constant_identifier_names
  bool GuestInputAlarm = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<GuestModel>(builder: (context, guest, child) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 50),
          child: Column(
            children: [
              if (GuestInputAlarm)
                Text(
                  'ニックネーム、出欠表を入力してください。',
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
                      '送信',
                      style: TextStyle(
                        fontSize: 20,
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
                      if (guest.markedPossibleDates != null) {
                        if (guest.markedPossibleDates.length > 0) {
                          submitPossibleDates(
                              url: widget.url,
                              nickname: guest.nickname,
                              comment: guest.comment,
                              markedPossibleDates: guest.markedPossibleDates,
                              onTapped: widget.onTapped);
                        } else {
                          setState(() {
                            GuestInputAlarm = true;
                          });
                        }
                      } else {
                        setState(() {
                          GuestInputAlarm = true;
                        });
                      }
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
