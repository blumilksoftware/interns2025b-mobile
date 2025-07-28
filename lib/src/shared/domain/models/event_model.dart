import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_owner.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/organization_model.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/owner_type.dart';
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
  final OwnerType ownerType;
  final int ownerId;
  final EventOwner? owner;
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
    required this.ownerId,
    required this.ownerType,
    this.owner,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final rawOwnerType = json['owner_type'] as String?;
    final ownerType = OwnerTypeX.fromRaw(rawOwnerType);
    final ownerJson = json['owner'];

    EventOwner? parsedOwner;
    if (ownerJson != null) {
      switch (ownerType) {
        case OwnerType.user:
          parsedOwner = User.fromJson(ownerJson);
          break;
        case OwnerType.organization:
          parsedOwner = Organization.fromJson(ownerJson);
          break;
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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'start': _formatDate(start),
      'end': _formatDate(end),
      'location': location,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'is_paid': isPaid,
      'price': price,
      'status': status.name,
      'image_url': imageUrl,
      'age_category': ageCategory,
      'owner_type': ownerType.name,
      'owner_id': ownerId,
    };
  }

  String? _formatDate(DateTime? dateTime) {
    if (dateTime == null) return null;
    return '${dateTime.year.toString().padLeft(4, '0')}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }
}
