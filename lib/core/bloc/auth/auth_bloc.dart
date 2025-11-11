// lib/core/bloc/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/core/bloc/base_bloc.dart';
import 'package:insyder/core/bloc/base_state.dart';

import '../../repository/auth_repo.dart';

part 'auth_event.dart';

class AuthBloc extends BaseBloc<AuthEvent, Map<String, dynamic>> {
  final AuthRepository _authRepo;

  AuthBloc(this._authRepo) : super() {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    //  on<FetchProfileRequested>(_onFetchProfile);
  }

  Future<void> _onLogin(LoginRequested event, Emitter emit) async {
    await handleRequest(() async {
      final success = await _authRepo.login(event.email, event.password);
      return {'loggedIn': success};
    });
  }

  Future<void> _onRegister(RegisterRequested event, Emitter emit) async {
    await handleRequest(() async {
      final success = await _authRepo.register(event.userData);
      return {'registered': success};
    });
  }

  Future<void> _onLogout(LogoutRequested event, Emitter emit) async {
    await handleRequest(() async {
      await _authRepo.logout();
      return {'loggedOut': true};
    });
  }

  // Future<void> _onFetchProfile(
  //     FetchProfileRequested event, Emitter emit) async {
  //   await handleRequest( () async {
  //     final profile = await _authRepo.getProfile();
  //     return profile ?? {};
  //   });
  // }
}
