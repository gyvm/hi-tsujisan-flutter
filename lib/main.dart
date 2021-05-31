import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import './screens/create_event_screen.dart';
import './screens/guest_screen.dart';
import './screens/event_screen.dart';

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
        // routes: {
        //   EventScreen.routeName: (context) => EventScreen(),
        // },
        onGenerateRoute: (settings) {
          if (settings.name == CreateEventScreen.routeName) {
            return MaterialPageRoute(builder: (context) => CreateEventScreen());
          }
          var uri = Uri.parse(settings.name.toString());
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'guest') {
            return MaterialPageRoute(
                builder: (context) => GuestScreen(url: uri.pathSegments[1]));
          }
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'event') {
            return MaterialPageRoute(
                builder: (context) => EventScreen(url: uri.pathSegments[1]));
          }
          // if (settings.name == EventScreen.routeName) {
          //   final args = settings.arguments as EventScreenArguments;
          //   return MaterialPageRoute(
          //     builder: (context) {
          //       return EventScreen(
          //         url: args.url,
          //       );
          //     },
          //   );
          // }
        });
  }
}
