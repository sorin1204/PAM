import '../../../../models/home_data.dart';

abstract class FeedRepository {
  Future<HomePageData> fetchFeed({required int version});
  Future<Map<String, dynamic>> fetchDetails({required int version});
}
