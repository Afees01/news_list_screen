import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchNews(int page) async {
    final response = await http.get(
      Uri.parse(
        //'https://newsapi.org/v2/everything?q=news&sortBy=publishedAt&page=$page&pageSize=10&apiKey=25733a1820104c2ea07f934364443605',
        'https://newsapi.org/v2/everything?q=news&sortBy=publishedAt&page=$page&pageSize=10&apiKey=9af73ff568dd430491b61d3b6ee40368',
        //'https://newsapi.org/v2/everything?q=news&sortBy=publishedAt&page=$page&pageSize=10&apiKey=6f89e3e3dd7f46a3b7a6e2b63ae11da7',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
