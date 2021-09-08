import 'package:flutter/material.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/event_info.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/possible_dates_table.dart';

import '../common/hexcolor.dart';

import '../common/h2text.dart';

import '../main.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// イベント情報の取得
class EventData {
  String name;
  String? description;
  List<dynamic> possibleDates;
  List<dynamic>? guestData;
  List<dynamic>? guestPossibleDates;
  Map<dynamic, dynamic>? dateRate;

  EventData(
      {required this.name,
      this.description,
      required this.possibleDates,
      this.guestData,
      this.guestPossibleDates,
      this.dateRate});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
        name: json['event_info']['name'],
        description: json['event_info']['description'],
        possibleDates: json['possible_dates'],
        guestData: json['guests_data'],
        guestPossibleDates: json['guest_possible_dates'],
        dateRate: json['date_rate']);
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
  EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Future<EventData>? _futureEventData;

  // @override
  // void initState() {
  //   super.initState();
  //   // イベント情報の取得
  //   // _futureEventData = getEvent(context: context, url: widget.url);
  //   // print(_futureEventData);
  //   // print("initState");
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EventScreenArguments;
    _futureEventData = getEvent(context: context, url: args.url);
    return (_futureEventData == null)
        ? CircularProgressIndicator()
        : FutureBuilder<EventData>(
            future: _futureEventData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              var data = snapshot.data;
              if (data != null) {
                print(data.name);
                print(data.description);
                print(data.guestData);
                print(data.guestPossibleDates);
                // print(data.possibleDates);
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32, bottom: 0, top: 0, right: 32),
                              child: Column(
                                children: [
                                  // Text(widget.url),
                                  if (data != null)
                                    EventInfo(
                                        url: args.url,
                                        eventName: data.name,
                                        eventDescription: data.description),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: H2Text(text: '出欠表'),
                                  ),
                                  if (data != null)
                                    PossibleDatesTable(
                                        possibleDates: data.possibleDates,
                                        guestData: data.guestData,
                                        guestPossibleDates:
                                            data.guestPossibleDates,
                                        dateRate: data.dateRate),
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
            });
  }
}
