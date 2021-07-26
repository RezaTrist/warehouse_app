import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/user_role_model.dart';
import 'package:warehouse_app/repo/repositories/role_api_repository.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  UserRoleBloc({required this.roleApiRepository}) : super(UserRoleInitial()) {
    add(LoadRole(amount: 2));
  }

  final RoleApiRepository roleApiRepository;

  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {
    if (event is LoadRole) {
      yield UserRoleLoading();
      try {
        final result =
            await roleApiRepository.getUserRoles(amount: event.amount);
        yield UserRoleDone(role: result);
      } catch (e) {
        yield UserRoleFailed();
      }
    }
  }
}
