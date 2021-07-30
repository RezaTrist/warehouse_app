part of 'user_login_bloc.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginDone extends UserLoginState {
  final String email;
  final String password;

  UserLoginDone({
    required this.email,
    required this.password,
  });
}

class UserLoginFailed extends UserLoginState {}
