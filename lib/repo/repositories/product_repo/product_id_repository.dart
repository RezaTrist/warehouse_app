import 'package:warehouse_app/models/product_model/id_product_model.dart';
import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetProductByIdFailure implements Exception {}

class GetProductByIdFailureInvalidProductId implements GetProductByIdFailure {}

class ProductByIdRepository {
  ProductByIdRepository({WarehouseApiProvider? warehouseApiProvider})
      : _provider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<IdProduct> getProductById({idProduct}) async {
    try {
      final result = await _provider.getProductById(idProduct);
      if (result is IdProduct) {
        return result;
      } else if (result is FailedResponse) {
        switch (result.errorKey) {
          case "error_invalid_product_id":
            throw GetProductByIdFailureInvalidProductId();

          default:
            throw GetProductByIdFailure();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw GetProductByIdFailure();
    }
  }
}
