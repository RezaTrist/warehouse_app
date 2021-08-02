part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStateChanged extends AuthenticationEvent {
  final FirebaseUser user;

  AuthenticationStateChanged({required this.user});

  @override
  List<Object> get props => [
        user,
      ];
}

class LogoutRequested extends AuthenticationEvent {}
