// lib/core/bloc/article/article_event.dart
part of 'article_bloc.dart';

abstract class ArticleEvent {}

class LoadArticles extends ArticleEvent {}

class CreateArticle extends ArticleEvent {
  final ArticleModel article;
  CreateArticle(this.article);
}

class UpdateArticle extends ArticleEvent {
  final ArticleModel article;
  UpdateArticle(this.article);
}
