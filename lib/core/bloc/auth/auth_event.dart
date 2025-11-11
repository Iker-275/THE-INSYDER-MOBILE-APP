// lib/core/bloc/auth/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final Map<String, dynamic> userData;
  RegisterRequested(this.userData);
}

class LogoutRequested extends AuthEvent {}

class FetchProfileRequested extends AuthEvent {}
