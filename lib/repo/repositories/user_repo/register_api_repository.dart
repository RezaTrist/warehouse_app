import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/models/user_model/user_register_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetUserRegisterFailure implements Exception {}

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
    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      throw GetUserRegisterFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
