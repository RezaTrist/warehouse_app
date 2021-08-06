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
    required String imageType,
    required String image64,
  }) async {
    AddProduct newProduct = AddProduct(
      typeId: typeId,
      name: name,
      price: price,
      imageType: imageType,
      image64: image64,
    );

    final result = await _provider.addProduct(newProduct);
    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      throw GetAddProductFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
