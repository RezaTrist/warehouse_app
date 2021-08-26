import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_app/blocs/delete_product_bloc/delete_product_bloc.dart';
import 'package:warehouse_app/blocs/id_product_bloc/id_product_bloc.dart';
import 'package:warehouse_app/repo/providers/api_providers/warehouse_api_provider.dart';
import 'package:warehouse_app/repo/repositories/product_repo/del_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/product_id_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';
// import 'package:warehouse_app/views/dashboard/product/detail_product/upd_product_page.dart';
// import 'package:warehouse_app/views/dashboard/product/product_page.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage(
      {Key? key,
      required this.productId,
      required DeleteProductRepository deleteProductRepository})
      : _deleteProductRepository = deleteProductRepository,
        super(key: key);

  final int productId;

  final DeleteProductRepository _deleteProductRepository;

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final WarehouseApiProvider provider = WarehouseApiProvider();

  late DeleteProductBloc _delProductBloc;

  ProductByIdRepository productByIdRepository = ProductByIdRepository();

  UpdateProductRepository updateProductRepository = UpdateProductRepository();

  // DeleteProductRepository deleteProductRepository = DeleteProductRepository();

  late IdProductBloc idProductBloc;

  void initState() {
    idProductBloc = IdProductBloc(productByIdRepository: productByIdRepository);
    _delProductBloc = DeleteProductBloc(
        deleteProductRepository: widget._deleteProductRepository);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    idProductBloc.add(LoadIdProduct(productId: widget.productId));
    super.didChangeDependencies();
  }

  Future<void> _showLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.green[700],
            size: 50,
            // controller: AnimationController(
            //     vsync: this, duration: const Duration(milliseconds: 1200)),
          );
        });
  }

  Future<void> _alertContentType() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Something went wrong, try again later.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text('Ok'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _alertErrorParam() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Something went wrong, please try again later.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text('Ok'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _alertErrorServer() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text(
                'Something went wrong on our server, please try again later.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text('Ok'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _alertInvalidProductId() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Product not found, please try again later.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text('Ok'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _alertInvalidUid() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Firebase ID not found, please try again later.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text('Ok'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showSnackbar() async {
    final snackBar = SnackBar(
      content: const Text('Product successfully deleted.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Are you sure want to disable this product?'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(context),
                    child: Text('No'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _delProductBloc.add(DisableProduct(
                          productId: widget.productId,
                          firebaseUid:
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .user
                                  .uid));
                      Navigator.of(context).pop(context);
                    },
                    child: Text('Yes'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(35, 42, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

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
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => idProductBloc),
              BlocProvider(create: (context) => _delProductBloc),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<IdProductBloc, IdProductState>(
                  listener: (context, state) {
                    // PRODUCT BY ID
                    if (state is IdProductLoading) {
                      _showLoading();
                    } else if (state is IdProductFailedById) {
                      Navigator.of(context).pop();
                      _alertInvalidProductId();
                    } else if (state is IdProductFailedContentType) {
                      Navigator.of(context).pop();
                      _alertContentType();
                    } else if (state is IdProductFailedInternalServer) {
                      Navigator.of(context).pop();
                      _alertErrorServer();
                    } else if (state is IdProductFailedParam) {
                      Navigator.of(context).pop();
                      _alertErrorParam();
                    } else if (state is IdProductDone) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                BlocListener<DeleteProductBloc, DeleteProductState>(
                    listener: (context, state) {
                  if (state is DeleteProductLoading) {
                    _showLoading();
                  } else if (state is DeleteProductFailedById) {
                    Navigator.of(context).pop();
                    _alertInvalidProductId();
                  } else if (state is DeleteProductFailedInternalServer) {
                    Navigator.of(context).pop();
                    _alertErrorServer();
                  } else if (state is DeleteProductFailureUid) {
                    Navigator.of(context).pop();
                    _alertInvalidUid();
                  } else if (state is DeleteProductDone) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/product');
                    // Navigator.of(context).popUntil((route) {
                    //   print('/detailprod ${route.settings.name}');
                    //   return route.settings.name == '/detailprod';
                    // });
                    _showSnackbar();
                  }
                })
              ],
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
                  disableButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imgProduct() {
    return BlocBuilder<IdProductBloc, IdProductState>(
      builder: (context, state) {
        if (state is IdProductDone) {
          return SizedBox(
            height: 250,
            width: 250,
            child: Image.network('${state.productId.data!.imageUrl}'),
          );
        }
        return Container();
      },
    );
  }

  Widget productPrice() {
    return BlocBuilder<IdProductBloc, IdProductState>(
      builder: (context, state) {
        if (state is IdProductDone) {
          return Card(
            color: Color.fromRGBO(226, 226, 226, 1),
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.tag,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Rp ${state.productId.data!.singlePrice}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget productName() {
    return BlocBuilder<IdProductBloc, IdProductState>(
      builder: (context, state) {
        if (state is IdProductDone) {
          return Card(
            color: Color.fromRGBO(226, 226, 226, 1),
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.cubes,
                    color: Colors.black,
                  ),
                  title: Text(
                    '${state.productId.data!.productName}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget typeProduct() {
    return BlocBuilder<IdProductBloc, IdProductState>(
      builder: (context, state) {
        if (state is IdProductDone) {
          return Card(
            color: Color.fromRGBO(226, 226, 226, 1),
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.cubes,
                    color: Colors.black,
                  ),
                  title: Text(
                    '${state.productId.data!.productTypeName}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget editButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: BlocBuilder<IdProductBloc, IdProductState>(
        builder: (context, state) {
          if (state is IdProductDone) {
            return ElevatedButton(
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
              onPressed: () {
                Navigator.of(context).pushNamed('/updateprod',
                    arguments: {'productId': state.productId.data!.productId!}
                    // MaterialPageRoute(
                    //     builder: (context) => UpdateProductPage(
                    //           productId: state.productId.data!.productId!,
                    //           updateProductRepository: updateProductRepository,
                    //         )),
                    );
                // Navigator.pushNamed(context, '/updateprod');
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(35, 42, 255, 1),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget disableButton() {
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
        onPressed: () {
          _showAlertDialog();
        },
        child: Text(
          'Disable',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(255, 0, 0, 1),
          ),
        ),
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

}
