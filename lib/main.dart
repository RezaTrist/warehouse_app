import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/views/dashboard/dashboard_page.dart';
import 'package:warehouse_app/views/dashboard/product/detail_product/detail_product_page.dart';
import 'package:warehouse_app/views/dashboard/product/product_page.dart';
import 'package:warehouse_app/views/dashboard/profile/profile_page.dart';
import 'package:warehouse_app/views/login_page.dart';
import 'package:warehouse_app/views/sign_up_page.dart';
import 'package:warehouse_app/views/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warehouse App',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/welcome':
            return MaterialPageRoute(builder: (context) => WelcomePage());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (context) => SignupPage());
          case '/dashboard':
            return MaterialPageRoute(builder: (context) => DashboardPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case '/product':
            return MaterialPageRoute(builder: (context) => ProductPage());
          case '/detailprod':
            return MaterialPageRoute(builder: (context) => DetailProductPage());
          default:
        }
      },
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/dashboard',
    );
  }
}
