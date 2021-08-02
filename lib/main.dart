import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/repo/repositories/firebase_auth_repository.dart';
import 'package:warehouse_app/repo/repositories/register_api_repository.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  Bloc.observer = CustomBlocObserver();
  final FirebaseAuthRepo _firebaseAuthRepo = FirebaseAuthRepo();
  final RegisterApiRepository _registerApiRepository = RegisterApiRepository();
  runApp(MyApp(
    firebaseAuthRepo: _firebaseAuthRepo,
    registerApiRepository: _registerApiRepository,
  ));
}
