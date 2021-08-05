import 'package:warehouse_app/models/product_model/type_product_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class GetProductTypeFailure implements Exception {}

class ProductTypeRepository {
  ProductTypeRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<ProductType>> getProductType({int? amount}) async {
    try {
      final result = await _provider.getProductType(amount ?? 1);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetProductTypeFailure();
    }
  }
}
