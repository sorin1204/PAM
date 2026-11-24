import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pam_ll1/main.dart';
import 'package:pam_ll1/cubit/gem_store_cubit.dart';
import 'package:pam_ll1/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:pam_ll1/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:pam_ll1/features/feed/domain/usecases/get_feed.dart';
import 'package:pam_ll1/features/feed/domain/usecases/get_feed_details.dart';
import 'package:pam_ll1/core/network/api_client.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('GemStoreApp smoke test', (WidgetTester tester) async {
    final json = await rootBundle.loadString('assets/data/lab_v1.json');
    final client = ApiClient(
      client: MockClient((http.Request request) async => http.Response(json, 200)),
    );
    final remoteDataSource = FeedRemoteDataSourceImpl(client);
    final repository = FeedRepositoryImpl(remoteDataSource);
    final cubit = GemStoreCubit(
      getFeed: GetFeed(repository),
      getFeedDetails: GetFeedDetails(repository),
    );
    await tester.pumpWidget(GemStoreApp(cubit: cubit));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('GemStore'), findsWidgets);
  });
}
