enum OwnerType { user, organization }

extension OwnerTypeX on OwnerType {
  static OwnerType fromRaw(String? value) {
    switch (value?.toLowerCase()) {
      case 'user':
      case 'interns2025b\\models\\user':
        return OwnerType.user;
      case 'organization':
      case 'interns2025b\\models\\organization':
        return OwnerType.organization;
      default:
        throw ArgumentError('Unknown owner type: $value');
    }
  }

  String get asString => name;
}
