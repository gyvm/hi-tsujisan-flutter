import 'package:flutter/material.dart';

import '../widgets/create_event_screen/event_form.dart';
import '../widgets/create_event_screen/calendar.dart';
import '../widgets/create_event_screen/submit_button.dart';
import '../widgets/create_event_screen/greeting.dart';

import '../model/event_model.dart';
import 'package:provider/provider.dart';

import '../common/hexcolor.dart';

class CreateEventScreen extends StatelessWidget {
  static const routeName = '/new';

  // final event = EventModel();

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
                  child: ChangeNotifierProvider(
                    create: (context) => EventModel(),
                    // update: (context, event) {
                    //   return event.eventName;s
                    // },
                    child: Column(
                      children: [
                        // EventForm(event: event),
                        Row(children: [
                          GreetingText(),
                          ElevatedButton(
                              onPressed: () {}, child: Text('button'))
                        ]),
                        EventForm(),
                        CalendarPage(),
                        SubmitButton(),
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
}
