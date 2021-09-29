// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../common/hexcolor.dart';
import '../../page_state.dart';

class EventName extends StatelessWidget {
  final String url;
  final String eventName;
  final ValueChanged<PageState> onTapped;

  const EventName({Key key, this.url, this.eventName, @required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 70),
      child: Container(
          child: Column(children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'イベント',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: eventName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#8A5C46'),
                ),
              ),
              TextSpan(
                text: 'の予定を入力してください！',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: InkWell(
            child: Text(
              'イベントの確認はこちら',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor('#8A5C46'),
              ),
            ),
            onTap: () {
              onTapped(
                  PageState(eventId: url, pageName: 'event', isUnknown: false));
            },
          ),
        )
      ])),
    );
  }
}
