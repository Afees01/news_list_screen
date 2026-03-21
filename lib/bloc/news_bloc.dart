import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_list_screen/bloc/news_event.dart';
import 'package:news_list_screen/bloc/news_state.dart';
import 'package:news_list_screen/data/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<FetchNews>(_fetchNews);
    on<RefreshNews>((event, emit) => add(FetchNews(page: event.page)));
  }

  Future<void> _fetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final news = await repository.getNews(event.page);
      emit(NewsLoaded(news: news, currentPage: event.page));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}