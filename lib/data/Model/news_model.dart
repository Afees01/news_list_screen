class NewsModel {
  final String title;
  final String imageUrl;
  final String source;
  final String date;
  final String url;

  NewsModel({
    required this.title,
    required this.imageUrl,
    required this.source,
    required this.date,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      source: json['source']?['name'] ?? '',
      date: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "urlToImage": imageUrl,
      "source": {"name": source},
      "publishedAt": date,
      "url": url,
    };
  }
}
