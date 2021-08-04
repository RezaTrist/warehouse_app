import 'dart:convert';
import 'package:warehouse_app/models/firebase_uid_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/models/user_register_model.dart';
import 'package:http/http.dart' as http;

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String _baseUrl =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0';

  Future registerUser(UserRegister registration) async {
    final Uri _url = Uri.parse('$_baseUrl/user/Create_user');

    try {
      final http.Response response = await _client.post(
        _url,
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode(registration),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        if (responseJson['message'] == 'Success') {
          print('Success');
          return SuccessResponse.fromJson(responseJson);
        } else {
          print('Failed');
          print('$Exception');
          return FailedResponse.fromJson(responseJson);
        }
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }

  Future loginUser(String firebaseUid) async {
    final Uri _url = Uri.parse('$_baseUrl/user/F_user/$firebaseUid');
    print(firebaseUid);
    try {
      final http.Response response = await _client.get(_url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        if (responseJson['message'] == 'Success') {
          print('Success');
          return ReadUserFirebase.fromJson(responseJson);
        } else {
          print('Failed');
          return FailedResponse.fromJson(responseJson);
        }
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }
}
