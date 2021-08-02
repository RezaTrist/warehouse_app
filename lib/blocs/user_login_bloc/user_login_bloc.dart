import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/repo/repositories/firebase_auth_repository.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc({required FirebaseAuthRepo firebaseAuthRepo})
      : _firebaseAuthRepo = firebaseAuthRepo,
        super(UserLoginInitial());

  final FirebaseAuthRepo _firebaseAuthRepo;

  @override
  Stream<UserLoginState> mapEventToState(
    UserLoginEvent event,
  ) async* {
    if (event is UserLogin) {
      yield UserLoginLoading();
      try {
        await _firebaseAuthRepo.loginWithCredentials(
          email: event.email,
          password: event.password,
        );
        yield UserLoginDone();
      } catch (e) {
        yield UserLoginFailed();
      }
    }
  }
}
