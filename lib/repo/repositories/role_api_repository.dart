import 'package:warehouse_app/repo/providers/api_providers/role_api_provider.dart';
import 'package:warehouse_app/models/user_role_model.dart';

class GetUserRoleFailure implements Exception {}

class RoleApiRepository {
  RoleApiRepository({RoleApiProvider? provider})
      : _provider = provider ?? RoleApiProvider();

  final RoleApiProvider _provider;

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
