import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/hexcolor.dart';
import '../model/event_model.dart';
import '../widgets/create_event_screen/event_info_form.dart';
import '../widgets/create_event_screen/calendar.dart';
import '../widgets/create_event_screen/submit_button.dart';
import '../widgets/create_event_screen/onboarding.dart';

class CreateEventScreen extends StatelessWidget {
  // static const routeName = '/new';
  final ValueChanged onTapped;
  CreateEventScreen({Key key, @required this.onTapped}) : super(key: key);

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
                    minWidth: 640,
                    minHeight: 0,
                    maxWidth: 720,
                    maxHeight: double.infinity,
                  ),
                  child: ChangeNotifierProvider(
                    create: (context) => EventModel(),
                    child: Column(
                      children: [
                        Row(children: [
                          Onboarding(),
                          ElevatedButton(
                              onPressed: () {}, child: Text('button'))
                        ]),
                        EventInfoForm(),
                        CalendarContainer(),
                        SubmitButton(tapSubmit: onTapped),
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
