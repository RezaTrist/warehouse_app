part of 'user_login_bloc.dart';

abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends UserLoginEvent {
  final String email;
  final String password;

  UserLogin({
    required this.email,
    required this.password,
  });
}
