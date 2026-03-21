abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final int page;
  FetchNews({this.page = 1});
}

class RefreshNews extends NewsEvent {
  final int page;
  RefreshNews({this.page = 1});
}