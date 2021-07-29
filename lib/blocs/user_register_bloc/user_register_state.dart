part of 'user_register_bloc.dart';

abstract class UserRegisterState extends Equatable {
  const UserRegisterState();

  @override
  List<Object> get props => [];
}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterLoading extends UserRegisterState {}

class UserRegisterDone extends UserRegisterState {
  // final int roleId;
  // final String name;
  // final String email;
  // final String password;

  // UserRegisterDone({
  //   required this.roleId,
  //   required this.name,
  //   required this.email,
  //   required this.password,
  // });
}

class UserRegisterFailed extends UserRegisterState {}
