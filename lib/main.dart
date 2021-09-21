// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import './screens/guest_screen.dart';
import 'configure_web.dart';
import 'event_route_path.dart';
import 'page_state.dart';
import 'screens/create_screen.dart';
import 'screens/details_screen.dart';
import 'screens/unkown_screen.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

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

class EventRouterDelegate extends RouterDelegate<EventRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<EventRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  EventRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  PageState _selectedEvent;
  bool show404 = false;

  void _handleNextScreen(PageState pageState) {
    _selectedEvent = pageState;
    if (_selectedEvent.isUnknown) {
      show404 = true;
    }
    notifyListeners();
  }

  EventRoutePath get currentConfiguration {
    if (show404) return EventRoutePath.unknown();
    if (_selectedEvent == null) return EventRoutePath.createScreen();

    if (_selectedEvent.isUnknown) return EventRoutePath.unknown();

    if (_selectedEvent.pageName == 'guest')
      return EventRoutePath.guestScreen(_selectedEvent.eventId);

    if (_selectedEvent.pageName == 'event')
      return EventRoutePath.detailsScreen(_selectedEvent.eventId);

    return EventRoutePath.createScreen();
  }

  // @override
  // GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('CreateScreen'),
          child: CreateScreen(
            onTapped: _handleNextScreen,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()),
        if (_selectedEvent?.pageName == 'guest')
          GuestPage(
            eventId: _selectedEvent.eventId,
            onTapped: _handleNextScreen,
          ),
        if (_selectedEvent?.pageName == 'event')
          DetailsPage(
            eventId: _selectedEvent.eventId,
            onTapped: _handleNextScreen,
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedEvent = null;
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
      _selectedEvent =
          PageState(eventId: null, pageName: null, isUnknown: true);
      show404 = true;
      return;
    }

    if (path.eventId.length == null)
      _selectedEvent =
          PageState(eventId: null, pageName: null, isUnknown: false);

    if ((path.hasEventId) && (path.getPageName == 'event')) {
      _selectedEvent =
          PageState(eventId: path.eventId, pageName: 'event', isUnknown: false);
    } else if ((path.hasEventId) && (path.getPageName == 'guest')) {
      _selectedEvent =
          PageState(eventId: path.eventId, pageName: 'guest', isUnknown: false);
    } else
      _selectedEvent = null;
    show404 = false;

    return;
  }
}

class DetailsPage extends Page {
  final eventId;
  final onTapped;

  DetailsPage({
    this.eventId,
    this.onTapped,
  }) : super(key: ValueKey(eventId));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return DetailsScreen(
          eventId: eventId,
          onTapped: onTapped,
        );
      },
    );
  }
}

class GuestPage extends Page {
  final String eventId;
  final onTapped;

  GuestPage({
    this.eventId,
    this.onTapped,
  }) : super(key: ValueKey(eventId));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return GuestScreen(
          eventId: eventId,
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

    if (uri.pathSegments.length == 0) return EventRoutePath.createScreen();

    if (uri.pathSegments.length == 2) {
      if ((uri.pathSegments.first != 'event') &&
          (uri.pathSegments.first != 'guest')) return EventRoutePath.unknown();

      final String eventId = uri.pathSegments.elementAt(1);
      // if (eventId == null) return EventRoutePath.unknown();
      if (uri.pathSegments.first == 'event')
        return EventRoutePath.detailsScreen(eventId);
      if (uri.pathSegments.first == 'guest')
        return EventRoutePath.guestScreen(eventId);
    }

    return EventRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(EventRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isCreatePage) {
      return RouteInformation(location: '/');
    }
    if (path.hasEventId) {
      if (path.getPageName == 'event') {
        return RouteInformation(location: '/event/${path.eventId}');
      }
      if (path.getPageName == 'guest') {
        return RouteInformation(location: '/guest/${path.eventId}');
      }
    }

    return null;
  }
}
