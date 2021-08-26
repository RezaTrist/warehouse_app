import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class DeleteProductFailure implements Exception {}

class DeleteProductFailureProductId implements DeleteProductFailure {}

class DeleteProductFailureServer implements DeleteProductFailure {}

class DeleteProductFailureUid implements DeleteProductFailure {}

class DeleteProductRepository {
  DeleteProductRepository({WarehouseApiProvider? warehouseApiProvider})
      : _provider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<SuccessResponse> deleteProductById({
    required int idProduct,
    required String firebaseUid,
  }) async {
    final result = await _provider.deleteProductById(
      idProduct,
      firebaseUid,
    );

    if (result is SuccessResponse) {
      return result;
    } else if (result is FailedResponse) {
      // print(result.errorKey);
      // throw DeleteProductFailure();
      switch (result.errorKey) {
        // ERROR 404
        case "error_invalid_product_id":
          throw DeleteProductFailureProductId();

        // ERROR 401
        case "error_invalid_uid":
          throw DeleteProductFailureUid();

        // ERROR 500
        case "error_internal_server":
          throw DeleteProductFailureServer();

        default:
          throw DeleteProductFailure();
      }
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
