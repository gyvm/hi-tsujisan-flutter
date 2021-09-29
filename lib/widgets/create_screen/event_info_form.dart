// import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../common/h2text.dart';
import '../../common/hexcolor.dart';
import '../../model/event_model.dart';

class EventInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: _eventNameContainer(context),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, bottom: 0, top: 0, right: 32),
            child: _eventDescriptionContainer(context),
          ),
        ],
      ),
    );
  }

  Widget _eventNameContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: 'イベント名を入力してください'),
        ),
        Form(
          child: TextFormField(
            maxLength: 30,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#F4EFED'),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
              hintText: "例) 山へ行こう / 飲み会しよう! / 読書会",
            ),
            cursorColor: HexColor('#8A5C46'),
            onChanged: (text) {
              if (text.length > 0) {
                var event = context.read<EventModel>();
                event.eventName = text;
              } else {}
            },
          ),
        ),
      ]),
    );
  }

  Widget _eventDescriptionContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      // constraints: BoxConstraints.tightFor(height: 150),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        // color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: '詳細情報を入力してください(オプション)'),
        ),
        Form(
          child: TextFormField(
            maxLines: 8,
            maxLength: 500,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#F4EFED'),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
              hintText: '''例)
都合良い時間教えて！
20時以降であればいつでもOK
身分証明証必要！！''',
            ),
            cursorColor: HexColor('#8A5C46'),
            onChanged: (text) {
              if (text.length > 0) {
                var event = context.read<EventModel>();
                event.eventDescription = text;
              } else {}
            },
          ),
        ),
      ]),
    );
  }
}
