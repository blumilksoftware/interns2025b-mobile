import 'package:flutter/cupertino.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_card.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class ProfileDetailsEvents extends StatelessWidget {
  final List<Event> events;

  const ProfileDetailsEvents({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events.map((e) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.eventDetails,
            arguments: e.id,
          ),
          child: EventCard(event: e),
        );
      }).toList(),
    );
  }
}
