part of 'user_role_bloc.dart';

abstract class UserRoleState extends Equatable {
  const UserRoleState();

  @override
  List<Object> get props => [];
}

class UserRoleInitial extends UserRoleState {}

class UserRoleLoading extends UserRoleState {}

class UserRoleDone extends UserRoleState {
  final List<UserRole> role;

  UserRoleDone({required this.role});

  @override
  List<Object> get props => [
        role,
      ];
}

class UserRoleFailed extends UserRoleState {}
