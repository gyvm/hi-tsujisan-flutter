import 'package:flutter/material.dart';

import '../widgets/guest_screen/possible_dates_table.dart';
import '../widgets/guest_screen/nickname_form.dart';
import '../widgets/guest_screen/guests_submit_button.dart';

import '../common/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import "package:intl/intl.dart";

import 'package:provider/provider.dart';
import '../model/guest_model.dart';

// イベント情報の取得
class EventData {
  String name;
  String? description;
  List<dynamic> possibleDates;

  EventData({this.name = 'a', this.description, required this.possibleDates});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      name: json['event_data']['name'],
      description: json['event_data']['description'],
      possibleDates: json['event_data']['possible_dates']['possible_dates'],
    );
  }
}

// イベント情報の取得
Future<EventData> getEvent(
    {required BuildContext context, required String url}) async {
  String requestUrl = 'http://localhost:3000/api/v1/events/' + url;
  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    // print(jsonDecode(response.body));
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Event.');
  }
}

class GuestScreen extends StatefulWidget {
  static const routeName = '/guest';
  GuestScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  Future<EventData>? _futureEventData;

  @override
  void initState() {
    super.initState();
    // イベント情報の取得
    _futureEventData = getEvent(context: context, url: widget.url);
    print(_futureEventData);
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("initState2" + _futureEventData.toString());
    return (_futureEventData == null)
        ? CircularProgressIndicator()
        : FutureBuilder<EventData>(
            future: _futureEventData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              var a = snapshot.data;
              if (a != null) {
                print(a.possibleDates);
                // var guest = context.read<GuestModel>();
                // guest.url = widget.url;
              }

              // return Center(child: (a != null) ? Text(a.name) : Text('error'));
              return SafeArea(
                child: Scaffold(
                  backgroundColor: HexColor('#EFE2DB'),
                  appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Text('👋🐑hi-tsuji-san'),
                      centerTitle: false,
                      automaticallyImplyLeading: false),
                  body: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              // minWidth: 640,
                              // minHeight: 0,
                              maxWidth: 720,
                              maxHeight: double.infinity,
                            ),
                            child: ChangeNotifierProvider(
                              create: (context) => GuestModel(),
                              child: Column(
                                children: [
                                  // Text(snapshot.data),
                                  (a != null) ? Text(a.name) : Text('error'),
                                  Text(widget.url),
                                  NicknameForm(),
                                  (a != null)
                                      ? (a.possibleDates != null)
                                          ? PossibleDatesTable(
                                              possibleDates: a.possibleDates)
                                          : Text('error')
                                      : Text('error'),
                                  GuestsSubmitButton(url: widget.url),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}
