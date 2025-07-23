import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class EventCreationPage extends ConsumerWidget {
  const EventCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            const Text(
              'Create Event',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Center(
                child: Text('Event Creation Form Goes Here'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
