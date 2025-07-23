enum EventStatus { draft, published, ongoing, ended, canceled }

extension EventStatusX on EventStatus {
  static EventStatus fromString(String? value) {
    return EventStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown event status: $value'),
    );
  }

  String get label {
    switch (this) {
      case EventStatus.draft:
        return 'Szkic';
      case EventStatus.published:
        return 'Opublikowane';
      case EventStatus.ongoing:
        return 'Trwa';
      case EventStatus.ended:
        return 'Zakończone';
      case EventStatus.canceled:
        return 'Anulowane';
    }
  }
}
