// lib/core/bloc/article/article_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/core/bloc/base_bloc.dart';
import 'package:insyder/core/bloc/base_state.dart';

import '../../models/article.dart';
import '../../repository/article_repo.dart';

part 'article_event.dart';

class ArticleBloc extends BaseBloc<ArticleEvent, List<ArticleModel>> {
  final ArticleRepository _articleRepo;

  ArticleBloc(this._articleRepo) {
    on<LoadArticles>(_onLoadArticles);
    on<CreateArticle>(_onCreateArticle);
    on<UpdateArticle>(_onUpdateArticle);
    on<SearchArticlesRequested>(_onSearchArticles);
    on<RefreshArticlesRequested>(_onRefreshArticles);
    on<ToggleArticleVisibility>(_onToggleVisibility);
  }

  Future<void> _onLoadArticles(
      LoadArticles event, Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      return await _articleRepo.getVisibleArticles(page: event.page);
    });
  }

  Future<void> _onCreateArticle(
      CreateArticle event, Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      await _articleRepo.create(event.article.toJson());
      return await _articleRepo.getAll();
    });
  }

  Future<void> _onUpdateArticle(
      UpdateArticle event, Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      await _articleRepo.update(event.article.id!, event.article.toJson());
      return await _articleRepo.getAll();
    });
  }

  Future<void> _onSearchArticles(SearchArticlesRequested event,
      Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      return await _articleRepo.searchArticles(
        query: event.query,
        genre: event.genre,
      );
    });
  }

  Future<void> _onRefreshArticles(RefreshArticlesRequested event,
      Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      return await _articleRepo.getVisibleArticles(page: event.page);
    });
  }

  Future<void> _onToggleVisibility(ToggleArticleVisibility event,
      Emitter<BaseState<List<ArticleModel>>> emit) async {
    await handleRequest(() async {
      await _articleRepo.toggleVisibility(event.id, event.visible);
      return await _articleRepo.getAll();
    });
  }
}
