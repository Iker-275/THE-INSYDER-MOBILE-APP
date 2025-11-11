// lib/core/bloc/author/author_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/core/bloc/base_bloc.dart';
import 'package:insyder/core/bloc/base_state.dart';

import '../../models/user.dart';
import '../../repository/author_repo.dart';

part 'author_event.dart';

class AuthorBloc extends BaseBloc<AuthorEvent, List<UserModel>> {
  final AuthorRepository _authorRepo;

  AuthorBloc(this._authorRepo) {
    on<LoadAuthors>(_onLoadAuthors);
    on<CreateAuthor>(_onCreateAuthor);
    on<UpdateAuthor>(_onUpdateAuthor);
  }

  Future<void> _onLoadAuthors(LoadAuthors event, Emitter emit) async {
    await handleRequest(() async {
      return await _authorRepo.getAll();
    });
  }

  Future<void> _onCreateAuthor(CreateAuthor event, Emitter emit) async {
    await handleRequest(() async {
      await _authorRepo.create(event.author.toJson());
      return await _authorRepo.getAll();
    });
  }

  Future<void> _onUpdateAuthor(UpdateAuthor event, Emitter emit) async {
    await handleRequest(() async {
      await _authorRepo.update(event.author.id!, event.author.toJson());
      return await _authorRepo.getAll();
    });
  }
}
