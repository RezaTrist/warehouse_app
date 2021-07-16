import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Warehouse App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/profile');
            },
            icon: Icon(FontAwesomeIcons.userCircle),
            color: Colors.black,
          ),
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 25,
              left: 25,
              bottom: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  endIndent: 25,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
