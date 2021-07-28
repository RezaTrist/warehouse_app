import 'package:warehouse_app/models/user_register_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
import 'package:warehouse_app/repo/repositories/role_api_repository.dart';

class GetUserRegisterFailure implements Exception {}

class RegisterApiRepository {
  RegisterApiRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  // Future<UserRegister> postUserRegister() async {
  //   try {
  //     final result = await _provider.postUserRegister();
  //     return result;
  //   } catch (e) {
  //     print(e.toString());
  //     throw GetUserRoleFailure();
  //   }
  // }
}
