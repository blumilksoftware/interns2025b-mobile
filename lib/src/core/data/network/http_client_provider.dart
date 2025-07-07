import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/data/network/http_client.dart';

final httpClientProvider = Provider<HttpClient>((ref) {
  final baseUrl = dotenv.env['API_URL']!;
  return HttpClient(baseUrl: baseUrl);
});
