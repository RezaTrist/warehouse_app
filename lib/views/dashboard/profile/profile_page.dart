import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_app/repo/repositories/user_repo/firebase_auth_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuthRepo firebaseAuthRepo = FirebaseAuthRepo();

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
        child: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
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
                  bottom: 20,
                ),
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.asset('assets/images/user1.png'),
                ),
              ),
              userName(),
              userRole(),
              userEmail(),
              signOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userName() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 2,
        ),
      ),
      elevation: 0,
      child: SizedBox(
        width: 310,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ListTile(
              leading: Icon(
                FontAwesomeIcons.solidUser,
                color: Colors.black,
              ),
              title: Text(
                'User Name',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userRole() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 2,
        ),
      ),
      elevation: 0,
      child: SizedBox(
        width: 310,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ListTile(
              leading: Icon(
                FontAwesomeIcons.solidUser,
                color: Colors.black,
              ),
              title: Text(
                'User Role',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userEmail() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 2,
        ),
      ),
      elevation: 0,
      child: SizedBox(
        width: 310,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ListTile(
              leading: Icon(
                FontAwesomeIcons.solidEnvelope,
                color: Colors.black,
              ),
              title: Text(
                'User Email',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signOutButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
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
            elevation: 2,
          ),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LogoutRequested());
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
    );
  }
}
