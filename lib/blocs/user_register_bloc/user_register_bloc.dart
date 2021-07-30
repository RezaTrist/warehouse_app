import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/repo/repositories/register_api_repository.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterBloc({required this.registerApiRepository})
      : super(UserRegisterInitial());

  final RegisterApiRepository registerApiRepository;

  @override
  Stream<UserRegisterState> mapEventToState(
    UserRegisterEvent event,
  ) async* {
    if (event is UserRegistration) {
      yield UserRegisterLoading();
      try {
        await registerApiRepository.registerUser(
          email: event.email,
          password: event.password,
          name: event.name,
          roleId: event.roleId,
        );
        yield UserRegisterDone();
      } catch (e) {
        yield UserRegisterFailed();
      }
    }
  }
}
