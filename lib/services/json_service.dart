import 'package:pam_ll1/core/network/api_client.dart';
import 'package:pam_ll1/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:pam_ll1/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:pam_ll1/features/feed/domain/repositories/feed_repository.dart';
import 'package:pam_ll1/features/feed/domain/usecases/get_feed.dart';
import 'package:pam_ll1/features/feed/domain/usecases/get_feed_details.dart';
import '../models/home_data.dart';

/// Backward-compatible facade; HTTP, repository, and use case code are separated
/// into core, data, and domain layers.
class JsonService {
  JsonService({FeedRepository? repository})
    : _repository = repository ?? FeedRepositoryImpl(
        FeedRemoteDataSourceImpl(ApiClient()),
      );

  final FeedRepository _repository;
  int apiVersion = 1;

  Future<HomePageData> loadData() async {
    try {
      return await GetFeed(_repository)(version: apiVersion);
    } catch (e) {
      throw Exception('Nu s-au putut încărca datele: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> loadDetails() =>
      GetFeedDetails(_repository)(version: apiVersion);

  void dispose() {
    if (_repository is FeedRepositoryImpl) _repository.close();
  }
}
