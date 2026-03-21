import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchNews(int page) async {
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&page=$page&pageSize=10&apiKey=25733a1820104c2ea07f934364443605',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
