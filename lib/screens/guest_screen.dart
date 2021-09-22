// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import "package:intl/intl.dart";
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../common/hexcolor.dart';
import '../main.dart';
import '../model/guest_model.dart';
import '../page_state.dart';
import '../widgets/guest_screen/event_name.dart';
import '../widgets/guest_screen/guest_possible_dates_table.dart';
import '../widgets/guest_screen/guest_submit_button.dart';
import '../widgets/guest_screen/nickname_form.dart';

// イベント情報の取得
class EventData {
  String name;
  String description;
  // List<dynamic> possibleDates;
  List<dynamic> possibleDates;

  EventData({this.name, this.description, this.possibleDates});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      name: json['event_info']['name'],
      description: json['event_info']['description'],
      possibleDates: json['possible_dates'],
    );
  }
}

// イベント情報の取得
Future<EventData> getEvent(
    {String url, ValueChanged<PageState> onTapped}) async {
  String requestUrl = 'https://hi-tsujisan.com/api/v1/events/' + url;
  final client = RetryClient(http.Client(),
      retries: 5,
      when: (response) =>
          ((response.statusCode == 502) || (response.statusCode == 503)),
      whenError: (dynamic error, StackTrace stackTrace) {
        print(stackTrace);
        return true;
      },
      onRetry: (http.BaseRequest request, http.BaseResponse response,
              int retryCount) =>
          print("retry!"));

  final response = await client.get(Uri.parse(requestUrl));
  try {
    if (response.statusCode == 200) {
      return EventData.fromJson(jsonDecode(response.body));
    } else {
      // throw Exception('Failed to get guest etails.');
      onTapped(PageState(eventId: null, pageName: null, isUnknown: true));
    }
  } finally {
    client.close();
  }
}

class GuestScreen extends StatefulWidget {
  // static const routeName = '/guest';
  final String eventId;
  final ValueChanged<PageState> onTapped;
  const GuestScreen({Key key, @required this.eventId, @required this.onTapped})
      : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  Future<EventData> _futureEventData;

  @override
  void initState() {
    super.initState();
    // イベント情報の取得
    _futureEventData = getEvent(url: widget.eventId, onTapped: widget.onTapped);
  }

  @override
  Widget build(BuildContext context) {
    print('guest screen (v0.1)');
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
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
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
                              EventName(
                                  url: widget.eventId,
                                  eventName: data.name,
                                  onTapped: widget.onTapped),
                              NicknameForm(),
                              PossibleDatesTable(
                                  possibleDates: data.possibleDates),
                              GuestsSubmitButton(
                                  url: widget.eventId,
                                  onTapped: widget.onTapped),
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
      },
    );
  }
}
