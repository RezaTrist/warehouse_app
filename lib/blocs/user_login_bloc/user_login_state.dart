part of 'user_login_bloc.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();
  
  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {}
