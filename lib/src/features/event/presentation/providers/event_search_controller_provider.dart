import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';

final eventSearchControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final controller = TextEditingController();
      final eventController = ref.read(eventsControllerProvider);
      controller.text = eventController.searchQuery;

      ref.onDispose(() {
        controller.dispose();
      });

      return controller;
    });
