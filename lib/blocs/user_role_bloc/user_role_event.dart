part of 'user_role_bloc.dart';

abstract class UserRoleEvent extends Equatable {
  const UserRoleEvent();

  @override
  List<Object> get props => [];
}

class LoadRole extends UserRoleEvent {
  final int amount;

  LoadRole({int? amount}) : amount = amount ?? 2;

  @override
  List<Object> get props => [
        amount,
      ];
}
