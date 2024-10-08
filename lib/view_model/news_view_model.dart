import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModels> fetchNewsChannelHeadlineApi() async {
    final response = await _rep.fetchNewsChannelHeadlineApi();
    return response;
  }
}
