import 'package:flutter/material.dart';
import '../models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel news;
  const NewsDetailScreen({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              Image.network(news.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(news.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(news.description),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                final url = Uri.parse(news.url);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Buka di Browser'),
            ),
          ],
        ),
      ),
    );
  }
} 