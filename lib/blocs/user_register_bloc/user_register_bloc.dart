import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterBloc() : super(UserRegisterInitial());

  @override
  Stream<UserRegisterState> mapEventToState(
    UserRegisterEvent event,
  ) async* {}
}
