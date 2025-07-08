import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsApiService {
  // Demo API key publik (hanya untuk testing, rate limit rendah)
  static const _apiKey = 'pub_23977e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2'; // Ganti dengan API key sendiri jika limit
  static const _baseUrl = 'https://newsdata.io/api/1/news';

  static Future<List<NewsModel>> fetchNews({String country = 'id'}) async {
    final url = Uri.parse('$_baseUrl?apikey=$_apiKey&country=$country&language=id');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil berita');
    }
    final data = json.decode(response.body);
    final List articles = data['results'] ?? [];
    return articles.map((json) => NewsModel(
      title: json['title'] ?? '',
      url: json['link'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
    )).toList();
  }
} 