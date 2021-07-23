import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/user_role_model.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  UserRoleBloc() : super(UserRoleInitial());

  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {}
}
