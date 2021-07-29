part of 'user_register_bloc.dart';

abstract class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object> get props => [];
}

class UserRegistration extends UserRegisterEvent {
  final String email;
  final int roleId;
  final String name;
  final String password;

  UserRegistration({
    required this.email,
    required this.roleId,
    required this.name,
    required this.password,
  });
}
