import 'package:flutter/material.dart';
import 'package:warehouse_app/views/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Warehouse App',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/welcome':
            return MaterialPageRoute(builder: (context) => WelcomePage());
          default:
        }
      },
      initialRoute: '/welcome',
    );
  }
}
