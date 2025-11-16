// lib/core/bloc/article/article_event.dart
part of 'article_bloc.dart';

abstract class ArticleEvent {}

class LoadArticles extends ArticleEvent {
  final int page;
  LoadArticles({this.page = 1});
}

class CreateArticle extends ArticleEvent {
  final ArticleModel article;
  CreateArticle(this.article);
}

class UpdateArticle extends ArticleEvent {
  final ArticleModel article;
  UpdateArticle(this.article);
}

class SearchArticlesRequested extends ArticleEvent {
  final String query;
  final String? genre;
  SearchArticlesRequested({required this.query, this.genre});
}

class RefreshArticlesRequested extends ArticleEvent {
  final int page;
  RefreshArticlesRequested({this.page = 1});
}

class ToggleArticleVisibility extends ArticleEvent {
  final String id;
  final bool visible;
  ToggleArticleVisibility(this.id, this.visible);
}
