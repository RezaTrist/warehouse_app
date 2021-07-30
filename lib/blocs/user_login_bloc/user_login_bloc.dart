import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/repo/providers/firebase_auth_provider.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc(this.firebaseAuth) : super(UserLoginInitial());

  final FirebaseAuthProvider firebaseAuth;

  @override
  Stream<UserLoginState> mapEventToState(
    UserLoginEvent event,
  ) async* {
    if (event is UserLogin) {
      yield UserLoginLoading();
      try {
        await firebaseAuth.loginWithEmailAndPassword(
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
