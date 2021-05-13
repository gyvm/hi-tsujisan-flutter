import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import './screens/create_event_screen.dart';
import './screens/guest_screen.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: CreateEventScreen.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == CreateEventScreen.routeName) {
            return MaterialPageRoute(builder: (context) => CreateEventScreen());
          }
          var uri = Uri.parse(settings.name.toString());
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'event') {
            return MaterialPageRoute(
                builder: (context) => GuestScreen(url: uri.pathSegments[1]));
          }
        });
  }
}
