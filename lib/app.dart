import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_app/repo/repositories/product_repo/add_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/del_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';
import 'package:warehouse_app/repo/repositories/user_repo/firebase_auth_repository.dart';
import 'package:warehouse_app/repo/repositories/user_repo/register_api_repository.dart';
import 'package:warehouse_app/views/dashboard/dashboard_runner.dart';
import 'package:warehouse_app/views/dashboard/product/detail_product/add_product_page.dart';
import 'package:warehouse_app/views/dashboard/product/detail_product/detail_product_page.dart';
import 'package:warehouse_app/views/dashboard/product/detail_product/upd_product_page.dart';
import 'package:warehouse_app/views/dashboard/product/product_page.dart';
import 'package:warehouse_app/views/dashboard/profile/profile_page.dart';
import 'package:warehouse_app/views/login_page.dart';
import 'package:warehouse_app/views/sign_up_page.dart';
import 'package:warehouse_app/views/welcome_page.dart';

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
    required FirebaseAuthRepo firebaseAuthRepo,
    required RegisterApiRepository registerApiRepository,
    required AddProductRepository addProductRepository,
    required UpdateProductRepository updateProductRepository,
    required DeleteProductRepository deleteProductRepository,
  })  : _firebaseAuthRepo = firebaseAuthRepo,
        _registerApiRepository = registerApiRepository,
        _addProductRepository = addProductRepository,
        _deleteProductRepository = deleteProductRepository,
        _updateProductRepository = updateProductRepository,
        super(key: key);

  final FirebaseAuthRepo _firebaseAuthRepo;
  final RegisterApiRepository _registerApiRepository;
  final AddProductRepository _addProductRepository;
  final DeleteProductRepository _deleteProductRepository;
  final UpdateProductRepository _updateProductRepository;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationBloc _authBloc;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    _authBloc = AuthenticationBloc(firebaseAuthRepo: widget._firebaseAuthRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Warehouse App',
      builder: (context, child) => BlocProvider(
        create: (context) => _authBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.Authenticated) {
              _navigator?.pushReplacementNamed('/dashboard');
            } else if (state.status == AuthenticationStatus.Unauthenticated) {
              _navigator?.pushReplacementNamed('/welcome');
            }
          },
          child: child,
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/welcome':
            return MaterialPageRoute(builder: (context) => WelcomePage());
          case '/login':
            return MaterialPageRoute(
                builder: (context) => LoginPage(
                      firebaseAuthRepo: widget._firebaseAuthRepo,
                    ));
          case '/signup':
            return MaterialPageRoute(
                builder: (context) => SignupPage(
                      registerApiRepository: widget._registerApiRepository,
                    ));
          case '/dashboard':
            return MaterialPageRoute(
                builder: (context) => DashboardRunnerPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case '/product':
            return MaterialPageRoute(
                builder: (context) => ProductPage(),
                settings: RouteSettings(name: '/product'));
          case '/addprod':
            return MaterialPageRoute(
                builder: (context) => AddProductPage(
                      addProductRepository: widget._addProductRepository,
                    ),
                settings: RouteSettings(name: '/addprod'));
          case '/detailprod':
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (context) => DetailProductPage(
                    productId: args['productId'],
                    deleteProductRepository: widget._deleteProductRepository),
                settings: RouteSettings(name: '/detailprod'));

          case '/updateprod':
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (context) => UpdateProductPage(
                    productId: args['productId'],
                    updateProductRepository: widget._updateProductRepository));

          default:
        }
      },
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/welcome' : '/dashboard',
    );
  }
}
