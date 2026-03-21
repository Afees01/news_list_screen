import 'dart:convert';
import 'package:news_list_screen/data/Model/news_model.dart';
import 'package:news_list_screen/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsRepository {
  final ApiService apiService;

  NewsRepository(this.apiService);

  Future<List<NewsModel>> getNews(int page) async {
    try {
      final data = await apiService.fetchNews(page);
      final news = data.map((e) => NewsModel.fromJson(e)).toList();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'cached_news',
        jsonEncode(news.map((e) => e.toJson()).toList()),
      );

      return news;
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('cached_news');

      if (cached != null) {
        final List decoded = jsonDecode(cached);
        return decoded.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception('No cached data');
      }
    }
  }
}