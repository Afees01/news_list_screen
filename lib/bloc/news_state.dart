import 'package:news_list_screen/data/Model/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  final bool hasMore;
  final bool isLoadingMore;

  NewsLoaded({
    required this.news,
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}