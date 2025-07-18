import 'package:flutter/material.dart';

class EventListLoader extends StatelessWidget {
  const EventListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
