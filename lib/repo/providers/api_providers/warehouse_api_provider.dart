import 'dart:convert';
import 'package:warehouse_app/models/user_register_model.dart';
import 'package:http/http.dart' as http;

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String _baseUrl =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0';

  Future registerUser(UserRegister registrasi) async {
    final Uri _url = Uri.parse('$_baseUrl/user/Create_user');

    try {
      final http.Response response = await _client.get(_url);
      if (response.statusCode == 200) {
        return UserRegister.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }
}
