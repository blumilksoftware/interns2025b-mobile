import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/domain/providers/get_event_by_id_usecase_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

final eventByIdProvider = FutureProvider.family<Event, int>((ref, id) async {
  final useCase = ref.watch(getEventByIdUseCaseProvider);
  return useCase(id);
});
