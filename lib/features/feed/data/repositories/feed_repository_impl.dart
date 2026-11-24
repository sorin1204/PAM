import 'package:pam_ll1/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:pam_ll1/features/feed/domain/repositories/feed_repository.dart';
import 'package:pam_ll1/models/home_data.dart';

class FeedRepositoryImpl implements FeedRepository {
  const FeedRepositoryImpl(this.remoteDataSource);
  final FeedRemoteDataSource remoteDataSource;

  void close() {
    if (remoteDataSource is FeedRemoteDataSourceImpl) {
      remoteDataSource.close();
    }
  }

  @override
  Future<HomePageData> fetchFeed({required int version}) =>
      remoteDataSource.fetchFeed(version);

  @override
  Future<Map<String, dynamic>> fetchDetails({required int version}) =>
      remoteDataSource.fetchDetails(version);
}
