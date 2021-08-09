import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/user_model/firebase_user_model.dart';
import 'package:warehouse_app/repo/repositories/user_repo/firebase_auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required FirebaseAuthRepo firebaseAuthRepo})
      : _firebaseAuthRepo = firebaseAuthRepo,
        super(AuthenticationState.unknown()) {
    _streamSubscription = _firebaseAuthRepo.user.listen((FirebaseUser user) {
      add(AuthenticationStateChanged(user: user));
    });
  }

  StreamSubscription<FirebaseUser>? _streamSubscription;
  FirebaseAuthRepo _firebaseAuthRepo;

  FirebaseUser get user => state.user;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStateChanged) {
      yield _mapEventToAuthenticationState(event);
    } else if (event is LogoutRequested) {
      await _firebaseAuthRepo.logout();
    }
  }

  AuthenticationState _mapEventToAuthenticationState(
      AuthenticationStateChanged event) {
    if (event.user == FirebaseUser.empty) {
      return AuthenticationState.unauthenticated();
    } else {
      return AuthenticationState.authenticated(event.user);
    }
  }
}
