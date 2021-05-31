import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            child: Row(children: [
          IconButton(
            icon: const Icon(Icons.content_copy_outlined),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: "your text"));
            },
          ),
          //https://stackoverflow.com/questions/55885433/flutter-dart-how-to-add-copy-to-clipboard-on-tap-to-a-app
          Text(
              'URL: httpd://hi-tsujisan.com/dsniufhq2839wojecnlkasndckunsozldn'),
        ])),
        Text('H3 イベント名'),
        Text('H2 イベント'),
        Text('H3 詳細'),
        Text(
            'H2 詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章詳細文章'),
      ],
    ));
  }
}
