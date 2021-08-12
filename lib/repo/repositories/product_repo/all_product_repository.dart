import 'package:warehouse_app/models/product_model/all_product_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetAllProductFailure implements Exception {}

class GetAllProductFailureInvalidProductId implements GetAllProductFailure {}

class AllProductRepository {
  AllProductRepository({WarehouseApiProvider? warehouseApiProvider})
      : _provider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<AllProduct> getAllProduct({allProduct}) async {
    try {
      final result = await _provider.getAllProduct(allProduct);
      if (result is AllProduct) {
        return result;
      } else if (result is FailedResponse) {
        switch (result.errorKey) {
          case "error_invalid_product_id":
            throw GetAllProductFailureInvalidProductId();

          default:
            throw GetAllProductFailure();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw GetAllProductFailure();
    }
  }
}
