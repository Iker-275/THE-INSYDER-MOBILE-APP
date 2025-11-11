// lib/core/bloc/author/author_event.dart
part of 'author_bloc.dart';

abstract class AuthorEvent {}

class LoadAuthors extends AuthorEvent {}

class CreateAuthor extends AuthorEvent {
  final UserModel author;
  CreateAuthor(this.author);
}

class UpdateAuthor extends AuthorEvent {
  final UserModel author;
  UpdateAuthor(this.author);
}
