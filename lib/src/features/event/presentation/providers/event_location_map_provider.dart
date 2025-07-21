import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_shared_map_notifier_provider.dart';

final eventLocationMapProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>(
      (ref) => MapNotifier(),
    );
