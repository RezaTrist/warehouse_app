import 'package:warehouse_app/models/product_model/id_product_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetProductByIdFailure implements Exception {}

class ProductByIdRepository {
  ProductByIdRepository({WarehouseApiProvider? warehouseApiProvider})
      : _provider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ProductById> getProductById({productById}) async {
    try {
      final result = await _provider.getProductById(productById);
      print(result);
      return result;
    } catch (e) {
      print(e.toString());
      throw GetProductByIdFailure();
    }
  }
}
