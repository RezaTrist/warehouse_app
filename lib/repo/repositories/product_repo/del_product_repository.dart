import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class DeleteProductFailure implements Exception {}

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
      print(result.errorKey);
      throw DeleteProductFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
