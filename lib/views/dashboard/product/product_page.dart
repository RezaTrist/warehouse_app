import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/all_product_bloc/all_product_bloc.dart';
import 'package:warehouse_app/models/product_model/all_product_model.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
import 'package:warehouse_app/repo/repositories/product_repo/all_product_repository.dart';

import 'detail_product/detail_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<AllProduct>> futureProduct;

  final WarehouseApiProvider provider = WarehouseApiProvider();

  AllProductRepository allProductRepository = AllProductRepository();

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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: BlocProvider(
              create: (context) =>
                  AllProductBloc(allProductRepository: allProductRepository),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 25,
                  bottom: 25,
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
                    productList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addprod');
        },
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
      ),
    );
  }

  Widget productList(List<AllProduct> allProduct) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: BlocBuilder<AllProductBloc, AllProductState>(
        builder: (context, state) {
          if (state is AllProductLoading) {
            CircularProgressIndicator(
              color: Colors.green,
            );
          } else if (state is AllProductFailed) {
            print('Failed');
          } else if (state is AllProductDone) {
            FutureBuilder(builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemBuilder: (context, position) {
                    return Card(
                      color: Color.fromRGBO(226, 226, 226, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailProductPage()),
                          );
                        },
                        child: SizedBox(
                          width: 330,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vitamin D3',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Rp 35.000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Text('Connection Failed');
            });
          }
          return Container();
        },
      ),
    );
  }
}
