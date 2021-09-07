import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/h2text.dart';
import '../../common/hexcolor.dart';

class EventInfo extends StatelessWidget {
  final String url;
  final String eventName;
  final String? eventDescription;

  EventInfo({
    required this.url,
    this.eventName = '未入力',
    this.eventDescription = 'a',
  }) : super();

  @override
  Widget build(BuildContext context) {
    String sharedUrl = 'hi-tsujisan.com/' + url;
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(children: [
              Text('イベントURLを共有して、出欠表を作りましょう'),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  icon: const Icon(
                    Icons.content_copy_outlined,
                    size: 20,
                  ),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "your text"));
                  },
                ),
                //https://stackoverflow.com/questions/55885433/flutter-dart-how-to-add-copy-to-clipboard-on-tap-to-a-app
                Text(
                  sharedUrl,
                  style: TextStyle(fontSize: 18),
                ),
              ]),
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
                eventDescription!,
                // style: TextStyle(color: HexColor('#8A5C46')),
              ),
            )),
      ],
    ));
  }
}
