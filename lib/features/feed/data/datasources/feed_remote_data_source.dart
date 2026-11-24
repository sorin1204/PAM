import 'package:pam_ll1/core/network/api_client.dart';
import 'package:pam_ll1/models/home_data.dart';

abstract class FeedRemoteDataSource {
  Future<HomePageData> fetchFeed(int version);
  Future<Map<String, dynamic>> fetchDetails(int version);
  void close();
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  FeedRemoteDataSourceImpl(this.client);
  final ApiClient client;
  static const _baseUrl = 'https://test-api-jlbn.onrender.com/lab2026';

  @override
  void close() => client.close();

  Uri _endpoint(int version, String path) {
    if (version < 1 || version > 4) throw const ApiException('Versiune API invalidă.');
    return Uri.parse('$_baseUrl/v$version/feed$path');
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    throw const ApiException('Structura JSON primită de la server nu este validă.');
  }

  @override
  Future<HomePageData> fetchFeed(int version) async =>
      HomePageData.fromJson(_asMap(await client.getJson(_endpoint(version, ''))));

  @override
  Future<Map<String, dynamic>> fetchDetails(int version) async =>
      _asMap(await client.getJson(_endpoint(version, '/details')));
}
