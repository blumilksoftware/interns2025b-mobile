import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class ProfileDataSource {
  final HttpClient httpClient;

  ProfileDataSource(this.httpClient);

  Future<User> getProfile() async {
    final response = await httpClient.get('/api/profile');
    return User.fromJson(response['data']);
  }

  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
  }) async {
    final localizations = AppLocalizations.of(context)!;

    final body = <String, dynamic>{};
    if (firstName != null && firstName.isNotEmpty) {
      body['first_name'] = firstName;
    }
    if (lastName != null) {
      body['last_name'] = lastName;
    }

    if (body.isEmpty) {
      throw Exception(localizations.profileUpdateNoFields);
    }

    await httpClient.put('/api/profile', body: body);
  }

  Future<void> deleteUserRequest() async {
    await httpClient.post('/api/profile/delete-request');
  }

  Future<User> getUserProfile(int userId) async {
    final response = await httpClient.get('/api/users/$userId');
    return User.fromJson(response['data']);
  }
}
