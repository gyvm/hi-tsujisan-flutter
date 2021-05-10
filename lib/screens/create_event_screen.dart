import 'package:flutter/material.dart';

import '../widgets/create_event_screen/event_form.dart';
import '../widgets/create_event_screen/calendar.dart';
import '../widgets/create_event_screen/submit_button.dart';

class CreateEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('👋🐑hi-tsuji-san'),
          centerTitle: false,
        ),
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
                      EventForm(),
                      CalendarPage(),
                      SubmitButton(),
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
