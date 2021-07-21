import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/views/dashboard/product/product_page.dart';
import 'package:warehouse_app/views/dashboard/profile/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
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
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  endIndent: 25,
                  thickness: 2,
                ),

                // WAREHOUSE BUTTON
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color.fromRGBO(0, 209, 77, 1),
                        width: 2,
                      ),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 330,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ListTile(
                              leading: Icon(
                                FontAwesomeIcons.warehouse,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Warehouse',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),

                  // PRODUCT BUTTON
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color.fromRGBO(0, 209, 77, 1),
                        width: 2,
                      ),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()),
                        );
                      },
                      child: SizedBox(
                        width: 330,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ListTile(
                              leading: Icon(
                                FontAwesomeIcons.cubes,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Product',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ORDER BUTTON
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Color.fromRGBO(0, 209, 77, 1),
                      width: 2,
                    ),
                  ),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 330,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ListTile(
                            leading: Icon(
                              FontAwesomeIcons.shoppingCart,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Order',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
