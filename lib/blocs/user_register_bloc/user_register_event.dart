part of 'user_register_bloc.dart';

abstract class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object> get props => [];
}

class UserRegisterEmailChanged extends UserRegisterEvent {
  final String email;

  UserRegisterEmailChanged({required this.email});
}

class UserRegisterPasswordChanged extends UserRegisterEvent {
  final String password;

  UserRegisterPasswordChanged({required this.password});
}

class UserRegisterNameChanged extends UserRegisterEvent {
  final String name;

  UserRegisterNameChanged({required this.name});
}

class UserRegisterRoleIdChanged extends UserRegisterEvent {
  final int roleId;

  UserRegisterRoleIdChanged({required this.roleId});
}
