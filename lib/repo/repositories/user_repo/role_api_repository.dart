import 'package:warehouse_app/models/user_model/user_role_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetUserRoleFailure implements Exception {}

class RoleApiRepository {
  RoleApiRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<UserRole>> getUserRoles({int? amount}) async {
    try {
      final result = await _provider.getUserRoles(amount ?? 1);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetUserRoleFailure();
    }
  }
}
