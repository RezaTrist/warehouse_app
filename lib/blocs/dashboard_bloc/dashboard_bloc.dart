import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/firebase_uid_model.dart';
import 'package:warehouse_app/models/firebase_user_model.dart';
import 'package:warehouse_app/repo/repositories/firebase_uid_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.firebaseUser}) : super(DashboardInitial());

  late final UserLogin _userLogin;

  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  final FirebaseUser firebaseUser;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadUser) {
      yield DashboardLoading();
      try {
        _userLogin = await _firebaseUserRepository.redirectToDashboard(
            firebaseUser: firebaseUser);
        print(_userLogin.email);
        print(_userLogin.name);
        print(_userLogin.userId);
        print(_userLogin.roleId);
        print(_userLogin.firebaseUid);
        yield DashboardDone();
      } catch (exception) {
        yield DashboardFailed();
      }
    }
  }
}
