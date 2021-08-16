import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/repo/repositories/product_repo/add_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';
import 'package:warehouse_app/repo/repositories/user_repo/firebase_auth_repository.dart';
import 'package:warehouse_app/repo/repositories/user_repo/register_api_repository.dart';

import 'app.dart';
import 'bloc_observer.dart';
// import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // setupServices();
  Bloc.observer = CustomBlocObserver();
  final FirebaseAuthRepo _firebaseAuthRepo = FirebaseAuthRepo();
  final RegisterApiRepository _registerApiRepository = RegisterApiRepository();
  final AddProductRepository _addProductRepository = AddProductRepository();
  final UpdateProductRepository _updateProductRepository =
      UpdateProductRepository();
  runApp(MyApp(
    firebaseAuthRepo: _firebaseAuthRepo,
    registerApiRepository: _registerApiRepository,
    addProductRepository: _addProductRepository,
    updateProductRepository: _updateProductRepository,
  ));
}
