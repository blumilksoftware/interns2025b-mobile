import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';

void sortEvents(List<Event> events) {
  events.sort((a, b) {
    bool aIsEndedOrCanceled =
        a.status == EventStatus.canceled || a.status == EventStatus.ended;
    bool bIsEndedOrCanceled =
        b.status == EventStatus.canceled || b.status == EventStatus.ended;

    if (aIsEndedOrCanceled && !bIsEndedOrCanceled) {
      return 1;
    } else if (!aIsEndedOrCanceled && bIsEndedOrCanceled) {
      return -1;
    }

    final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    return bDate.compareTo(aDate);
  });
}
