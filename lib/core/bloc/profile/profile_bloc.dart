import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/core/bloc/profile/profile_events.dart';

import '../../models/user.dart';
import '../../repository/author_repo.dart';
import '../../utils/secure_storage.dart';
import '../base_bloc.dart';
import '../base_state.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, UserModel> {
  final AuthorRepository _repo;

  ProfileBloc(this._repo) : super() {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<CreateProfile>(_onCreateProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<BaseState<UserModel>> emit) async {
    await handleRequest(() async {
      final userId = await SecureStorageService.getUserId();
      if (userId == null) throw "User ID not found. Please login again.";
      return await _repo.getCurrentUser(userId);
    });
  }

  Future<void> _onCreateProfile(
      CreateProfile event, Emitter<BaseState<UserModel>> emit) async {
    await handleRequest(() async {
      final user = await _repo.createAuthor(event.data);

      // Save ID locally after creation
      if (user.id != null) {
        await SecureStorageService.saveUserId(user.id!);
      }

      return user;
    });
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event, Emitter<BaseState<UserModel>> emit) async {
    await handleRequest(() async {
      final userId = await SecureStorageService.getUserId();
      if (userId == null) throw "Missing user ID. Cannot update profile.";
      return await _repo.updateCurrentUser(userId, event.data);
    });
  }
}
