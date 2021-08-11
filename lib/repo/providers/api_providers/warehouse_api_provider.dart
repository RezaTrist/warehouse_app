import 'dart:convert';
import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/models/product_model/all_product_model.dart';
import 'package:warehouse_app/models/product_model/type_product_model.dart';
import 'package:warehouse_app/models/user_model/firebase_uid_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/models/user_model/user_register_model.dart';
import 'package:http/http.dart' as http;
import 'package:warehouse_app/models/user_model/user_role_model.dart';

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String _baseUrl =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_2_0';

  // REGISTER
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

  // USER BY UID
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

  // ROLE USER
  Future<UserPack> getUserRoles(int amount) async {
    final Uri _url = Uri.parse('$_baseUrl/user/User_role');

    try {
      final http.Response response = await _client.get(_url);
      if (response.statusCode == 200) {
        return UserPack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ADD NEW PRODUCT
  Future addProduct(AddProduct newProduct, String firebaseUid) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product');

    try {
      final http.Response response = await _client.post(
        _url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Firebase_UID": firebaseUid,
        },
        body: jsonEncode(newProduct),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        if (responseJson['message'] == 'Success') {
          print('Success');
          return SuccessResponse.fromJson(responseJson);
        } else {
          print('Failed');
          print(response.body);
          return FailedResponse.fromJson(responseJson);
        }
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }

  // READ ALL PRODUCT
  Future<AllProduct> getAllProduct(int allProduct) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product_all');

    try {
      final http.Response response = await _client.get(_url);
      if (response.statusCode == 200) {
        return AllProduct.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }

  // PRODUCT TYPE
  Future<ProductTypePack> getProductType(int typeId) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product_type');

    try {
      final http.Response response = await _client.get(_url);
      if (response.statusCode == 200) {
        return ProductTypePack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }
}
