import 'package:flutter/material.dart';

import '../widgets/guest_screen/possible_dates_table.dart';
import '../widgets/guest_screen/nickname_form.dart';
import '../widgets/guest_screen/submit_button.dart';

class GuestScreen extends StatelessWidget {
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
                      NicknameForm(),
                      PossibleDatesTable(),
                      SubmitButton(),
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
