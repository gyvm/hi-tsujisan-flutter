import 'package:flutter/material.dart';

import './screens/attendees_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hatchout Calendar',
      home: AttendeesScreen(),
    );
  }
}
