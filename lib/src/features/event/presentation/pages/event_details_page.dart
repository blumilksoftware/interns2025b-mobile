import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_by_id_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_details_body.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class EventDetails extends ConsumerWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventId = ModalRoute.of(context)!.settings.arguments as int;
    final eventAsync = ref.watch(eventByIdProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        data: (event) => EventDetailsBody(event: event),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }
}
