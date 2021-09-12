import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import './screens/create_event_screen.dart';
import './screens/guest_screen.dart';
import './screens/event_screen.dart';

import 'package:google_fonts/google_fonts.dart';

import 'event_route_path.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.kosugiMaruTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       initialRoute: CreateEventScreen.routeName,
//       routes: {
//         CreateEventScreen.routeName: (context) => CreateEventScreen(),
//         EventScreen.routeName: (context) => EventScreen(),
//         GuestScreen.routeName: (context) => GuestScreen(),
//       },
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = EventRouterDelegate();
  final _routeInformationParser = EventRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hitsujisan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.kosugiMaruTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

// class EventScreenArguments {
//   final String url;

//   EventScreenArguments(this.url);
// }

class EventRouterDelegate extends RouterDelegate<EventRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EventRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  EventRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  String _id;
  bool show404 = false;
  String _pageName = 'event';

  void _handleGoEventPage(String id) {
    _id = id;
    _pageName = 'event';
    notifyListeners();
  }

  void _handleGoGuestPage(String id) {
    _id = id;
    _pageName = 'guest';
    notifyListeners();
  }

  EventRoutePath get currentConfiguration {
    if (show404) return EventRoutePath.unknown();

    if (_id == null) return EventRoutePath.createscreen();

    return EventRoutePath.eventscreen(_id);
  }

  // @override
  // GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('CreateEventPage'),
          child: CreateEventScreen(
            onTapped: _handleGoEventPage,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if ((_pageName != 'event') || (_pageName != 'guest'))
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if ((_id != null) && (_pageName == 'event'))
          EventPage(id: _id)
        else if ((_id != null) && (_pageName == 'guest'))
          GuestPage(
            id: _id,
            onTapped: _handleGoEventPage,
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _id = null;
        _pageName = 'event';
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  // when update of route, updates the app state
  @override
  Future<void> setNewRoutePath(EventRoutePath path) async {
    if (path.isUnknown) {
      _id = null;
      show404 = true;
      // have an empty return to end the function
      return;
    }

    if (path.isEventPage || path.isGuestPage) {
      if (path.id.length <= 0) {
        show404 = true;
        return;
      }
      _id = path.id;
    } else {
      _id = null;
    }

    show404 = false;
  }
}

class EventPage extends Page {
  final id;

  EventPage({
    this.id,
  }) : super(key: ValueKey(id));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return EventScreen(id: id);
      },
    );
  }
}

class GuestPage extends Page {
  final String id;
  final onTapped;

  GuestPage({
    this.id,
    this.onTapped,
  }) : super(key: ValueKey(id));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return GuestScreen(
          id: id,
          onTapped: onTapped,
        );
      },
    );
  }
}

class EventRouteInformationParser
    extends RouteInformationParser<EventRoutePath> {
  @override
  Future<EventRoutePath> parseRouteInformation(
      RouteInformation routeInfo) async {
    final uri = Uri.parse(routeInfo.location);

    if (uri.pathSegments.length == 0) return EventRoutePath.createscreen();

    if (uri.pathSegments.length == 2) {
      if ((uri.pathSegments.first != 'event') ||
          (uri.pathSegments.first != 'guest')) return EventRoutePath.unknown();
      final String id = uri.pathSegments.elementAt(1);
      if (id == null) return EventRoutePath.unknown();
      if (uri.pathSegments.first == 'event')
        return EventRoutePath.eventscreen(id);
      if (uri.pathSegments.first == 'guest')
        return EventRoutePath.guestscreen(id);
    }

    return EventRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(EventRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isCreateEventPage) {
      return RouteInformation(location: '/');
    }
    if (path.isEventPage) {
      return RouteInformation(location: '/event/${path.id}');
    }
    if (path.isGuestPage) {
      return RouteInformation(location: '/guest/${path.id}');
    }

    return null;
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
