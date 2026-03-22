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
      final List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();

      final prefs = await SharedPreferences.getInstance();
      final String? cachedString = prefs.getString('cached_news');
      
      List<NewsModel> allCached = [];
      if (cachedString != null) {
        final List decoded = jsonDecode(cachedString);
        allCached = decoded.map((e) => NewsModel.fromJson(e)).toList();
      }

      final Set<String> existingTitles = allCached.map((e) => e.title).toSet();
      for (var item in news) {
        if (!existingTitles.contains(item.title)) {
          allCached.add(item);
        }
      }

      prefs.setString(
        'cached_news',
        jsonEncode(allCached.map((e) => e.toJson()).toList()),
      );

      return news;
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('cached_news');

      if (cached != null) {
        final List decoded = jsonDecode(cached);
        final List<NewsModel> allOfflineNews = decoded.map((e) => NewsModel.fromJson(e)).toList();

        // Offline pagination mathematically serving segments from the master cache
        final int startIndex = (page - 1) * 10;
        if (startIndex < allOfflineNews.length) {
          final int endIndex = (startIndex + 10 > allOfflineNews.length) 
              ? allOfflineNews.length 
              : startIndex + 10;
          return allOfflineNews.sublist(startIndex, endIndex);
        } else {
          return []; // Gracefully end pagination when cache is fully scrolled!
        }
      } else {
        throw Exception('Failed to load news');
      }
    }
  }
}