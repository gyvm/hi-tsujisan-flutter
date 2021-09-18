class EventRoutePath {
  final String eventId;
  final String pageName;
  final bool isUnknown;

  EventRoutePath.createScreen()
      : eventId = null,
        pageName = null,
        isUnknown = false;

  EventRoutePath.detailsScreen(this.eventId)
      : pageName = 'event',
        isUnknown = false;

  EventRoutePath.guestScreen(this.eventId)
      : pageName = 'guest',
        isUnknown = false;

  EventRoutePath.unknown()
      : eventId = null,
        pageName = null,
        isUnknown = true;

  bool get isCreatePage => eventId == null;

  bool get hasEventId => eventId != null;

  String get getPageName => pageName;
}
