import 'package:get_it/get_it.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
// import 'package:warehouse_app/repo/repositories/role_api_repository.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerLazySingleton<WarehouseApiProvider>(
      () => WarehouseApiProvider());
}
