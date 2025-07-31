import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/profile/data/data_sources/profile_data_source.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class RemoteProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;

  RemoteProfileRepository(this.dataSource);

  @override
  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
  }) =>
      dataSource.updateProfile(
        context: context,
        firstName: firstName,
        lastName: lastName,
      );

  @override
  Future<User> getProfile() => dataSource.getProfile();

  @override
  Future<void> deleteUserRequest() => dataSource.deleteUserRequest();

  @override
  Future<User> getUserProfile(int userId) => dataSource.getUserProfile(userId);
}

