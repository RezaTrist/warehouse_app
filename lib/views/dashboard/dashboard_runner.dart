import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:warehouse_app/models/user_model/firebase_user_model.dart';
import 'package:warehouse_app/views/dashboard/dashboard_page.dart';

class DashboardRunnerPage extends StatefulWidget {
  DashboardRunnerPage({Key? key}) : super(key: key);

  @override
  _DashboardRunnerPage createState() => _DashboardRunnerPage();
}

class _DashboardRunnerPage extends State<DashboardRunnerPage> {
  FirebaseUser firebaseUser = FirebaseUser(uid: 'wTeQvYGXaPafhoyDC0PVpgRNs5T2');

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc(firebaseUser: firebaseUser),
      child: DashboardPage(),
    );
  }
}
