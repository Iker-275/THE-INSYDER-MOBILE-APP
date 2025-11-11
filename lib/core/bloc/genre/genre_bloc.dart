// lib/core/bloc/genre/genre_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/core/bloc/base_bloc.dart';
import '../../models/genre.dart';
import '../../repository/genre_repo.dart';

part 'genre_event.dart';

class GenreBloc extends BaseBloc<GenreEvent, List<GenreModel>> {
  final GenreRepository _genreRepo;

  GenreBloc(this._genreRepo) {
    on<LoadGenres>(_onLoadGenres);
    on<CreateGenre>(_onCreateGenre);
  }

  Future<void> _onLoadGenres(LoadGenres event, Emitter emit) async {
    await handleRequest(() async {
      return await _genreRepo.getAll();
    });
  }

  Future<void> _onCreateGenre(CreateGenre event, Emitter emit) async {
    await handleRequest(() async {
      await _genreRepo.create(event.genre.toJson());
      return await _genreRepo.getAll();
    });
  }

  Future<void> _onUpdateGenre(UpdateGenre event, Emitter emit) async {
    await handleRequest(() async {
      await _genreRepo.update(event.genre.id!, event.genre.toJson());
      return await _genreRepo.getAll();
    });
  }
}
