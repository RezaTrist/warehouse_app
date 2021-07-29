part of 'user_register_bloc.dart';

abstract class UserRegisterState extends Equatable {
  const UserRegisterState();

  @override
  List<Object> get props => [];
}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterLoading extends UserRegisterState {}

class UserRegisterDone extends UserRegisterState {
  late final int? roleId;
  bool get isValidRoleId => (roleId == 0 || roleId == 1);

  late final String email;
  bool get isValidEmail => email.contains('@');

  late final String password;
  bool get isValidPassword => password.length > 6;

  late final String name;
  bool get isValidName => name.length > 3;

  UserRegisterDone({
    this.roleId,
    this.email = '',
    this.password = '',
    this.name = '',
  });

  UserRegisterDone copyWith({
    required int roleId,
    required String email,
    required String password,
    required String name,
  }) {
    return UserRegisterDone(
      roleId: roleId,
      email: email,
      password: password,
      name: name,
    );
  }
}
