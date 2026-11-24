import '../repositories/feed_repository.dart';

class GetFeedDetails {
  const GetFeedDetails(this.repository);
  final FeedRepository repository;

  Future<Map<String, dynamic>> call({required int version}) =>
      repository.fetchDetails(version: version);
}
