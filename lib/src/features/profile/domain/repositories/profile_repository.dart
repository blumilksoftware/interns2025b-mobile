import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

abstract class ProfileRepository {
  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
  });

  Future<User> getProfile();
  Future<void> deleteUserRequest();
}
