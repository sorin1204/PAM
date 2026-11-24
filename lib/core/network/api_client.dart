import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  void close() => _client.close();

  Future<dynamic> getJson(Uri uri) async {
    try {
      final response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 25));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException('Serverul a răspuns cu codul ${response.statusCode}.');
      }
      try {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } on FormatException {
        throw const ApiException('Răspunsul serverului nu este JSON valid.');
      }
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Nu s-a putut contacta serviciul web: $error');
    }
  }

}
