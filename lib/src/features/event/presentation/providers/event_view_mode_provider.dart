import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EventViewMode { list, map }

final eventViewModeProvider = StateProvider<EventViewMode>((ref) {
  return EventViewMode.list;
});
