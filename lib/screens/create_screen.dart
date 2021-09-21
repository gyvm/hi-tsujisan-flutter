// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../common/hexcolor.dart';
import '../model/event_model.dart';
import '../page_state.dart';
import '../widgets/create_screen/calendar.dart';
import '../widgets/create_screen/event_info_form.dart';
import '../widgets/create_screen/onboarding.dart';
import '../widgets/create_screen/submit_button.dart';
import '../widgets/guest_screen/guest_submit_button.dart';

class CreateScreen extends StatelessWidget {
  // static const routeName = '/new';
  final ValueChanged<PageState> onTapped;
  CreateScreen({Key key, @required this.onTapped}) : super(key: key);

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
                        Onboarding(),
                        EventInfoForm(),
                        CalendarContainer(),
                        SubmitButton(onTapped: onTapped),
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
