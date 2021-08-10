import 'package:warehouse_app/models/product_model/all_product_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetAllProductFailure implements Exception {}

class AllProductRepository {
  AllProductRepository({WarehouseApiProvider? warehouseApiProvider})
      : _provider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<AllProduct>> getAllProduct({productId}) async {
    try {
      final result = await _provider.getAllProduct(productId);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetAllProductFailure();
    }
  }
}
