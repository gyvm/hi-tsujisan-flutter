class EventRoutePath {
  final String id;
  final bool isUnknown;

  EventRoutePath.createscreen()
      : id = null,
        isUnknown = false;

  EventRoutePath.eventscreen(this.id) : isUnknown = false;

  EventRoutePath.guestscreen(this.id) : isUnknown = false;

  EventRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isCreateEventPage => id == null;

  bool get isEventPage => id != null;

  bool get isGuestPage => id != null;
}
