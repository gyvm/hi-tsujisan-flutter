// import 'dart:html';

import 'package:flutter/material.dart';

import '../../model/event_model.dart';

import '../../common/hexcolor.dart';
import '../../common/h2text.dart';

import 'package:provider/provider.dart';

class EventForm extends StatelessWidget {
  // final event = EventModel();
  // EventForm({Key? key, required this.event}) : super(key: key);

  // var event = EventModel();

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
        color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        H2Text(text: 'イベント名を教えて下さい!'),
        Form(
          child: TextFormField(
            maxLength: 30,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "イベント名：",
            ),
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
        color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        H2Text(text: '詳細情報はありますか？(オプション)'),
        Form(
          child: TextFormField(
            maxLines: 8,
            maxLength: 500,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "補足事項：",
            ),
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
