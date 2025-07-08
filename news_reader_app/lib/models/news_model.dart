// Model data berita untuk News Reader App
// TODO: Tambahkan field sesuai response API berita

class NewsModel {
  final String title;
  final String url;
  final String imageUrl;
  final String description;

  NewsModel({
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.description,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      description: json['description'] ?? '',
    );
  }
} 