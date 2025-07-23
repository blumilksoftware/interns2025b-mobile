import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/organization_model.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class Event {
  final int id;
  final String title;
  final String? description;
  final DateTime? start;
  final DateTime? end;
  final String? location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isPaid;
  final double? price;
  final EventStatus status;
  final String? imageUrl;
  final String? ageCategory;
  final String ownerType;
  final int ownerId;
  final dynamic owner;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.id,
    required this.title,
    this.description,
    this.start,
    this.end,
    this.location,
    this.address,
    this.latitude,
    this.longitude,
    required this.isPaid,
    this.price,
    required this.status,
    this.imageUrl,
    this.ageCategory,
    required this.ownerType,
    required this.ownerId,
    this.owner,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final ownerType = (json['owner_type'] as String?) ?? '';
    final ownerJson = json['owner'];

    dynamic parsedOwner;
    if (ownerJson != null) {
      final ownerTypeLower = ownerType.toLowerCase();

      if (ownerTypeLower.contains('user')) {
        parsedOwner = User.fromJson(ownerJson);
      } else if (ownerTypeLower.contains('organization')) {
        parsedOwner = Organization.fromJson(ownerJson);
      }
    }

    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      start: json['start'] != null ? DateTime.tryParse(json['start']) : null,
      end: json['end'] != null ? DateTime.tryParse(json['end']) : null,
      location: json['location'],
      address: json['address'],
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      isPaid: json['is_paid'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      status: EventStatusX.fromString(json['status']),
      imageUrl: json['image_url'],
      ageCategory: json['age_category'],
      ownerType: ownerType,
      ownerId: json['owner_id'],
      owner: parsedOwner,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
