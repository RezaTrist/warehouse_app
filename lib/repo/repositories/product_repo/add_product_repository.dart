import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetAddProductFailure implements Exception {}

class AddProductRepository {
  AddProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<SuccessResponse> addProduct({
    required int typeId,
    required String name,
    required String price,
    required ImageProduct image,
    required String firebaseUid,
  }) async {
    AddProduct newProduct = AddProduct(
      typeId: typeId,
      name: name,
      price: price,
      image: image,
    );

    final result = await _provider.addProduct(newProduct, firebaseUid);

    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      print(result.errorKey);
      throw GetAddProductFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
