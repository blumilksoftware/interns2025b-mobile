import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';

final eventScrollControllerProvider = Provider.autoDispose<ScrollController>((
  ref,
) {
  final controller = ScrollController();
  final eventsController = ref.read(eventsControllerProvider.notifier);

  void loadMore() {
    try {
      final state = ref.read(eventsControllerProvider);
      if (controller.position.pixels >=
              controller.position.maxScrollExtent - 200 &&
          state.hasMore &&
          !state.isLoading) {
        eventsController.loadEvents();
      }
    } catch (_) {}
  }

  controller.addListener(loadMore);

  ref.onDispose(controller.dispose);

  return controller;
});
