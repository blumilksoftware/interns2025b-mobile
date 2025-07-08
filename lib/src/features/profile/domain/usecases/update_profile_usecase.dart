import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call({
    required BuildContext context,
    String? firstName,
    String? lastName,
  }) {
    return repository.updateProfile(
      context: context,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
