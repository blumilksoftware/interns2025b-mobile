import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:interns2025b_mobile/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:interns2025b_mobile/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/localization_controller.dart';
import 'package:provider/provider.dart';

import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';
import 'package:interns2025b_mobile/src/core/presentation/app_initializer.dart';

class AppSetup {
  static Future<Widget> initialize() async {
    await dotenv.load(fileName: '.env');
    final apiUrl = dotenv.env['API_URL'];

    if (apiUrl == null || apiUrl.isEmpty) {
      throw Exception('API_URL is not set in the .env file');
    }

    final httpClient = HttpClient(baseUrl: apiUrl);
    final authDataSource = AuthDataSource(httpClient);
    final authRepository = AuthRepositoryImpl(authDataSource);

    final registerUseCase = RegisterUseCase(authRepository);
    final loginUseCase = LoginUseCase(authRepository);

    final localizationController = LocalizationController();
    await localizationController.loadLocale();

    final authController = AuthController(
      registerUseCase: registerUseCase,
      loginUseCase: loginUseCase,
    );
    await authController.loadUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(value: authController),
        ChangeNotifierProvider<LocalizationController>.value(
          value: localizationController,
        ),
      ],
      child: const AppInitializer(),
    );
  }
}
