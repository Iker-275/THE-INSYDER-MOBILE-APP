// lib/core/bloc/genre/genre_event.dart
part of 'genre_bloc.dart';

abstract class GenreEvent {}

class LoadGenres extends GenreEvent {}

class CreateGenre extends GenreEvent {
  final GenreModel genre;
  CreateGenre(this.genre);
}

class UpdateGenre extends GenreEvent {
  final GenreModel genre;
  UpdateGenre(this.genre);
}
