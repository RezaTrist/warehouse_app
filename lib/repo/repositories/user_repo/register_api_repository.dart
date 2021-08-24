import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/models/user_model/user_register_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetUserRegisterFailure implements Exception {}

class GetUserRegisterFailureUsedFb implements GetUserRegisterFailure {}

class GetUserRegisterFailureUsed implements GetUserRegisterFailure {}

class GetUserRegisterFailureParam implements GetUserRegisterFailure {}

class GetUserRegisterFailureServer implements GetUserRegisterFailure {}

class RegisterApiRepository {
  RegisterApiRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<SuccessResponse> registerUser({
    required String email,
    required String password,
    required String name,
    required int roleId,
  }) async {
    UserRegister registration = UserRegister(
      email: email,
      password: password,
      name: name,
      roleId: roleId,
    );

    final result = await _provider.registerUser(registration);
    print(result.runtimeType);
    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      switch (result.errorKey) {
        case "error_email_is_used_fb":
          throw GetUserRegisterFailureUsedFb();

        case "error_email_is_used":
          throw GetUserRegisterFailureUsed();

        // ERROR 400
        case "error_param":
          throw GetUserRegisterFailureParam();

        // ERROR 500
        case "error_internal_server":
          throw GetUserRegisterFailureServer();

        default:
          throw GetUserRegisterFailure();
      }
    } else {
      // print(Exception());
      throw Exception();
    }
  }
}
