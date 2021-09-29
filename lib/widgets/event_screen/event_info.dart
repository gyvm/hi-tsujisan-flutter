// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import '../../common/h2text.dart';
import '../../common/hexcolor.dart';
import '../../page_state.dart';

class EventInfo extends StatelessWidget {
  final String url;
  final String eventName;
  final String eventDescription;
  final ValueChanged<PageState> onTapped;

  EventInfo({
    this.url,
    this.eventName = '未入力',
    this.eventDescription = 'a',
    @required this.onTapped,
  }) : super();

  @override
  Widget build(BuildContext context) {
    String sharedUrl = 'hi-tsujisan.com/event/' + url;
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 70),
            child: Column(children: [
              Text(
                'イベントURLを共有して出欠表を作りましょう',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  icon: Icon(
                    Icons.content_copy_outlined,
                    size: 20,
                    color: HexColor('#8A5C46'),
                  ),
                  tooltip: 'コピーする',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: sharedUrl));
                  },
                ),
                //https://stackoverflow.com/questions/55885433/flutter-dart-how-to-add-copy-to-clipboard-on-tap-to-a-app

                SelectableText(
                  sharedUrl,
                  style: TextStyle(fontSize: 16),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      child: Text(
                        '予定入力はこちら',
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
                        onTapped(PageState(
                            eventId: url, pageName: 'guest', isUnknown: false));
                      }),
                ),
              )
            ])),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: 'イベント'),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: HexColor('#F4EFED'),
              ),
              child: Text(
                eventName,
                style: TextStyle(
                  // color: HexColor('#8A5C46'),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: '詳細'),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: HexColor('#F4EFED'),
              ),
              child: Text(
                eventDescription,
                // style: TextStyle(color: HexColor('#8A5C46')),
              ),
            )),
      ],
    ));
  }
}
