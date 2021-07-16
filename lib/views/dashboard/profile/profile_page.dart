import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/repo/providers/firebase_auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuthProvider provider = FirebaseAuthProvider();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                    provider.logOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 18,
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
