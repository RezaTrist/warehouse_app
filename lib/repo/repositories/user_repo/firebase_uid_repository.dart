import 'package:warehouse_app/models/response_model.dart';
import 'package:warehouse_app/models/user_model/firebase_uid_model.dart';
import 'package:warehouse_app/models/user_model/firebase_user_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';

class FirebaseUserFailure implements Exception {}

class FirebaseUserByIdFailure implements FirebaseUserFailure {}

class FirebaseUserRepository {
  FirebaseUserRepository({WarehouseApiProvider? warehouseApiProvider})
      : _warehouseApiProvider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _warehouseApiProvider;

  Future redirectToDashboard({required FirebaseUser firebaseUser}) async {
    final result = await _warehouseApiProvider.loginUser(firebaseUser.uid);
    if (result is ReadUserFirebase) {
      return result.data;
    } else if (result is FailedResponse) {
      switch (result.errorKey) {
        // ID Not Found
        case "error_no_data_found":
          throw FirebaseUserByIdFailure();

        default:
          throw FirebaseUserFailure();
      }
    } else {
      throw Exception();
    }
  }
}
