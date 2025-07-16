class Organization {
  final int id;
  final String name;
  final String? groupUrl;
  final String? avatarUrl;
  final OwnerPreview? owner;

  Organization({
    required this.id,
    required this.name,
    this.groupUrl,
    this.avatarUrl,
    this.owner,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      groupUrl: json['group_url'],
      avatarUrl: json['avatar_url'],
      owner: json['owner'] != null ? OwnerPreview.fromJson(json['owner']) : null,
    );
  }
}

class OwnerPreview {
  final int? id;
  final String? firstName;
  final String? lastName;

  OwnerPreview({this.id, this.firstName, this.lastName});

  factory OwnerPreview.fromJson(Map<String, dynamic> json) {
    return OwnerPreview(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
