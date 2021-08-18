import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 40,
              ),
              child: SizedBox(
                width: 180,
                height: 180,
                child: Image.asset('assets/images/user1.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: new Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(163, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        width: 2,
                      ),
                    ),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LogoutRequested());
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
