import '../../../../models/home_data.dart';
import '../repositories/feed_repository.dart';

class GetFeed {
  const GetFeed(this.repository);
  final FeedRepository repository;

  Future<HomePageData> call({required int version}) =>
      repository.fetchFeed(version: version);
}
