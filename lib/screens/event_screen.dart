import 'package:flutter/material.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/event_info.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/possible_dates_table.dart';

import '../common/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// イベント情報の取得
class EventData {
  String name;
  String? description;
  List<dynamic> possibleDates;

  EventData(
      {required this.name, this.description, required this.possibleDates});

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
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Event.');
  }
}

class EventScreen extends StatefulWidget {
  static const routeName = '/event';
  EventScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
                            child: Column(
                              children: [
                                //説明文を記載する
                                //button: 出家席を入力する
                                Text(widget.url),
                                // Text(args.url),
                                EventInfo(),
                                if (a != null)
                                  PossibleDatesTable(
                                      possibleDates: a.possibleDates),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            });
  }
}
