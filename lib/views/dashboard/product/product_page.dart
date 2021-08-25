import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/all_product_bloc/all_product_bloc.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
import 'package:warehouse_app/repo/repositories/product_repo/all_product_repository.dart';
// import 'package:warehouse_app/repo/repositories/product_repo/del_product_repository.dart';
// import 'package:warehouse_app/views/dashboard/product/detail_product/detail_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  final WarehouseApiProvider provider = WarehouseApiProvider();

  AllProductRepository allProductRepository = AllProductRepository();

  // DeleteProductRepository deleteProductRepository = DeleteProductRepository();

  Future<void> _showLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.green[700],
            size: 50,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: BlocProvider(
          create: (context) =>
              AllProductBloc(allProductRepository: allProductRepository),
          child: BlocListener<AllProductBloc, AllProductState>(
            listener: (context, state) {
              if (state is AllProductLoading) {
                _showLoading();
              } else if (state is AllProductDone) {
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 25,
                bottom: 25,
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
                  Container(
                    height: size.height * 0.9,
                    child: productList(),
                  ),
                ],
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

  Widget productList() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: BlocBuilder<AllProductBloc, AllProductState>(
        builder: (context, state) {
          if (state is AllProductDone) {
            return ListView.builder(
              itemCount: state.name.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromRGBO(226, 226, 226, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      print(state.name.data![index].productId);
                      Navigator.of(context).pushNamed('/detailprod',
                          arguments: {
                            'productId': state.name.data![index].productId
                          }
                          // MaterialPageRoute(
                          //     builder: (context) => DetailProductPage(
                          //           productId: state.name.data![index].productId!,
                          //         )),
                          );
                    },
                    child: SizedBox(
                      width: 330,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.name.data![index].productName.toString()}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Rp ${state.name.data![index].singlePrice.toString()}',
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
          }
          return Container();
        },
      ),
    );
  }
}
