import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';

final eventScrollControllerProvider = Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();

  controller.addListener(() {
    final state = ref.read(eventsControllerProvider);
    final notifier = ref.read(eventsControllerProvider.notifier);

    if (controller.position.pixels < controller.position.maxScrollExtent - 200) {
      return;
    }

    if (!state.hasMore || state.isLoading) {
      return;
    }

    notifier.loadEvents();
  });

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});
