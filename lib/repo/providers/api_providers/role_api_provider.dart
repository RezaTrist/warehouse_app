import 'dart:convert';
import 'package:warehouse_app/models/user_role_model.dart';
import 'package:http/http.dart' as http;

class RoleApiProvider {
  RoleApiProvider({http.Client? role}) : _role = role ?? http.Client();

  final http.Client _role;
  final String _baseUrl =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Api/user/User_role';

  Future<UserPack> getUserRoles(int amount) async {
    final Uri _url = Uri.parse('$_baseUrl?amount=$amount');

    try {
      final http.Response response = await _role.get(_url);
      if (response.statusCode == 200) {
        return UserPack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }
}
