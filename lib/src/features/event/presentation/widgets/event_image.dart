import 'package:flutter/material.dart';

class EventImage extends StatelessWidget {
  final String? imageUrl;

  const EventImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const SizedBox.shrink();
    }
    return Image.network(
      imageUrl!,
      width: double.infinity,
      height: 180,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 180,
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            size: 64,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
