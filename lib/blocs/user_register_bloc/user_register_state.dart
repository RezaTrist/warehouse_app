part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  const UserRegisterState();

  @override
  List<Object> get props => [];
}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterLoading extends UserRegisterState {}

class UserRegisterDone extends UserRegisterState {}

// class UserRegisterFailed extends UserRegisterState {}

class UserRegisterFailedUsedFb extends UserRegisterState {}

class UserRegisterFailedUsed extends UserRegisterState {}

class UserRegisterFailedParam extends UserRegisterState {}

class UserRegisterFailedInternalServer extends UserRegisterState {}
