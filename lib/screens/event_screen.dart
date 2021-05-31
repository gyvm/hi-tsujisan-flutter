import 'package:flutter/material.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/event_info.dart';
import 'package:hi_tsujisan_frontend/widgets/event_screen/possible_dates_table.dart';

import '../common/hexcolor.dart';

// class EventScreenArguments {
//   final String url;
//   EventScreenArguments(this.url);
// }

class EventScreen extends StatelessWidget {
  static const routeName = '/event';
  EventScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
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
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                      Text(url),
                      // Text(args.url),
                      EventInfo(),
                      PossibleDatesTable(),
                      //button: 出家席を入力する
                      Placeholder(
                        color: Colors.green,
                        fallbackHeight: 500,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
