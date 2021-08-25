import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class UpdateProductFailure implements Exception {}

class UpdateProductFailureInvalidUid implements UpdateProductFailure {}

class UpdateProductFailureInvalidId implements UpdateProductFailure {}

class UpdateProductFailureParam implements UpdateProductFailure {}

class UpdateProductFailureContentType implements UpdateProductFailure {}

class UpdateProductFailureServer implements UpdateProductFailure {}

class UpdateProductRepository {
  UpdateProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<SuccessResponse> updateProduct({
    required int typeId,
    required String name,
    required String price,
    ImageProduct? image,
    required String firebaseUid,
    required int idProduct,
  }) async {
    AddProduct updateProduct = AddProduct(
      typeId: typeId,
      name: name,
      price: price,
      image: image,
    );

    final result = await _provider.updateProduct(
      updateProduct,
      idProduct,
      firebaseUid,
    );

    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      switch (result.errorKey) {
        // ERROR 401
        case "error_invalid_uid":
          throw UpdateProductFailureInvalidUid();

        // ERROR 404
        case "error_invalid_product_id":
          throw UpdateProductFailureInvalidId();

        // ERROR 400
        case "error_param":
          throw UpdateProductFailureParam();

        // ERROR 415
        case "error_content-type":
          throw UpdateProductFailureContentType();

        // ERROR 500
        case "error_internal_server":
          throw UpdateProductFailureServer();

        default:
          throw UpdateProductFailure();
      }
    } else {
      // print(Exception());
      throw Exception();
    }
  }

  Future<String> networkImageToBase64({
    required String imageUrl,
  }) async {
    return _provider.networkImageToBase64(imageUrl);
  }
}
