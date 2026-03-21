import 'package:news_list_screen/data/Model/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  final int currentPage;

  NewsLoaded({
    required this.news,
    this.currentPage = 1,
  });
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}