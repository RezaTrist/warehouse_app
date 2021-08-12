import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/id_product_bloc/id_product_bloc.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
import 'package:warehouse_app/repo/repositories/product_repo/id_product_repository.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key? key}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  late Future<Map<String, dynamic>> futureProductId;

  final WarehouseApiProvider provider = WarehouseApiProvider();

  ProductByIdRepository productByIdRepository = ProductByIdRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warehouse App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) =>
                IdProductBloc(productByIdRepository: productByIdRepository),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product',
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
                    ],
                  ),
                ),
                imgProduct(),
                productName(),
                productPrice(),
                typeProduct(),
                editButton(),
                banButton(),
                // productLeft(),
                // productStock(),
                // productDescription(),
                // warehouseSources(),
                // warehouseAddress(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imgProduct() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.image,
              color: Colors.black,
            ),
            title: Text(
              'Image',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget productPrice() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.tag,
              color: Colors.black,
            ),
            title: Text(
              'Rp 35.000',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget productName() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.cubes,
              color: Colors.black,
            ),
            title: Text(
              'Vitamin D3',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeProduct() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.cubes,
              color: Colors.black,
            ),
            title: Text(
              'Drug & Healthcare',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Widget productLeft() {
  //   return Card(
  //     color: Color.fromRGBO(226, 226, 226, 1),
  //     elevation: 0,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         const ListTile(
  //           leading: Icon(
  //             FontAwesomeIcons.cubes,
  //             color: Colors.black,
  //           ),
  //           title: Text(
  //             '5 Left',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget productStock() {
  //   return Card(
  //     color: Color.fromRGBO(226, 226, 226, 1),
  //     elevation: 0,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         const ListTile(
  //           leading: Icon(
  //             FontAwesomeIcons.cubes,
  //             color: Colors.black,
  //           ),
  //           title: Text(
  //             '10 Stock',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget productDescription() {
  //   return Card(
  //     color: Color.fromRGBO(226, 226, 226, 1),
  //     elevation: 0,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         const ListTile(
  //           leading: Icon(
  //             FontAwesomeIcons.alignJustify,
  //             color: Colors.black,
  //           ),
  //           title: Text(
  //             'Membantu tubuh menyerap kalsium dan fosfor yang penting untuk membangun dan menjaga tulang yang kuat',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget warehouseSources() {
  //   return Card(
  //     color: Color.fromRGBO(226, 226, 226, 1),
  //     elevation: 0,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         const ListTile(
  //           leading: Icon(
  //             FontAwesomeIcons.warehouse,
  //             color: Colors.black,
  //           ),
  //           title: Text(
  //             'Warehouse-Century',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget warehouseAddress() {
  //   return Card(
  //     color: Color.fromRGBO(226, 226, 226, 1),
  //     elevation: 0,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         const ListTile(
  //           leading: Icon(
  //             FontAwesomeIcons.mapMarkerAlt,
  //             color: Colors.black,
  //           ),
  //           title: Text(
  //             'Jl. Limo No.40, RT.8/RW.10, Grogol Sel., Kec. Kby. Lama, Kota Jakarta Selatan',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget editButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(320, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Color.fromRGBO(35, 42, 255, 1),
              width: 2,
            ),
          ),
          primary: Colors.white,
        ),
        onPressed: () {},
        child: Text(
          'Edit',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(35, 42, 255, 1),
          ),
        ),
      ),
    );
  }

  Widget banButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      // BAN BUTTON
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(320, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Color.fromRGBO(255, 0, 0, 1),
              width: 2,
            ),
          ),
          primary: Colors.white,
        ),
        onPressed: () {},
        child: Text(
          'Ban',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(255, 0, 0, 1),
          ),
        ),
      ),
    );
  }
}
