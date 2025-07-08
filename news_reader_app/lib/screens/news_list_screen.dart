import 'package:flutter/material.dart';
import '../services/news_api_service.dart';
import '../models/news_model.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<NewsModel>> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = NewsApiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berita Terkini')),
      body: FutureBuilder<List<NewsModel>>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          }
          final newsList = snapshot.data ?? [];
          if (newsList.isEmpty) {
            return const Center(child: Text('Tidak ada berita'));
          }
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, i) {
              final news = newsList[i];
              return ListTile(
                leading: news.imageUrl.isNotEmpty
                    ? Image.network(news.imageUrl, width: 60, height: 60, fit: BoxFit.cover)
                    : const Icon(Icons.article),
                title: Text(news.title),
                subtitle: Text(news.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(news: news),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 