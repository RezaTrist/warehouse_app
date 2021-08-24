import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetAddProductFailure implements Exception {}

class GetAddProductFailureInvalidUid implements GetAddProductFailure {}

class GetAddProductFailureInvalidId implements GetAddProductFailure {}

class GetAddProductFailureParam implements GetAddProductFailure {}

class GetAddProductFailureContentType implements GetAddProductFailure {}

class GetAddProductFailureServer implements GetAddProductFailure {}

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
      switch (result.errorKey) {
        // ERROR 401
        case "error_invalid_uid":
          throw GetAddProductFailureInvalidUid();

        // ERROR 404
        case "error_invalid_product_id":
          throw GetAddProductFailureInvalidId();

        // ERROR 400
        case "error_param":
          throw GetAddProductFailureParam();

        // ERROR 415
        case "error_content-type":
          throw GetAddProductFailureContentType();

        // ERROR 500
        case "error_internal_server":
          throw GetAddProductFailureServer();

        default:
          throw GetAddProductFailure();
      }
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
