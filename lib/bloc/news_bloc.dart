import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_list_screen/bloc/news_event.dart';
import 'package:news_list_screen/bloc/news_state.dart';
import 'package:news_list_screen/data/Model/news_model.dart';
import 'package:news_list_screen/data/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  int page = 1;
  bool hasMore = true;
  List<NewsModel> allNews = [];

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<FetchNews>(_fetchNews);
    on<FetchMoreNews>(_fetchMore);
    on<RefreshNews>((event, emit) => add(FetchNews()));
  }

  Future<void> _fetchNews(
      FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    try {
      page = 1;
      final news = await repository.getNews(page);

      allNews = news;
      hasMore = news.isNotEmpty;

      emit(NewsLoaded(news: allNews));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _fetchMore(
      FetchMoreNews event, Emitter<NewsState> emit) async {
    if (!hasMore || state is! NewsLoaded) return;

    final currentState = state as NewsLoaded;

    emit(NewsLoaded(
      news: currentState.news,
      isLoadingMore: true,
    ));

    try {
      page++;
      final news = await repository.getNews(page);

      if (news.isEmpty) {
        hasMore = false;
      } else {
        allNews.addAll(news);
      }

      emit(NewsLoaded(news: allNews, hasMore: hasMore));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}