// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:hi_tsujisan_frontend/widgets/event_screen/event_info.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/possible_dates_table.dart';
import '../common/h2text.dart';
import '../common/hexcolor.dart';
import '../main.dart';
import '../page_state.dart';

// イベント情報の取得
class EventData {
  String name;
  String description;
  List<dynamic> possibleDates;
  List<dynamic> guestData;
  List<dynamic> guestPossibleDates;
  Map<dynamic, dynamic> dateRate;

  EventData(
      {this.name,
      this.description,
      this.possibleDates,
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
    {String url, ValueChanged<PageState> onTapped}) async {
  String requestUrl = 'http://localhost:3000/api/v1/events/' + url;
  final response = await http.get(Uri.parse(requestUrl));
  if (response.statusCode == 200) {
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    // throw Exception('Failed to get event etails.');
    onTapped(PageState(eventId: null, pageName: null, isUnknown: true));
  }
}

class DetailsScreen extends StatefulWidget {
  // static const routeName = '/event';
  final String eventId;
  final ValueChanged<PageState> onTapped;
  DetailsScreen({Key key, @required this.eventId, @required this.onTapped})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<EventData> _futureEventData;

  @override
  void initState() {
    super.initState();
    // イベント情報の取得
    _futureEventData = getEvent(url: widget.eventId, onTapped: widget.onTapped);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventData>(
        future: _futureEventData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (snapshot.hasData) {
            var data = snapshot.data;
            return SafeArea(
              child: Scaffold(
                backgroundColor: HexColor('#EFE2DB'),
                appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      '👋🐑',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
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
                                      url: widget.eventId,
                                      eventName: data.name,
                                      eventDescription: data.description,
                                      onTapped: widget.onTapped),
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
          }
          return Container(
            color: HexColor('#EFE2DB'),
            child: Center(
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(HexColor('#8A5C46')))),
            ),
          );
        });
  }
}
