import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:warehouse_app/blocs/add_product_bloc/add_product_bloc.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_app/blocs/type_product_bloc/type_product_bloc.dart';
import 'package:warehouse_app/models/product_model/type_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/add_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/type_product_repository.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage(
      {Key? key, required AddProductRepository addProductRepository})
      : _addProductRepository = addProductRepository,
        super(key: key);

  final AddProductRepository _addProductRepository;

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _prodKey = GlobalKey();

  late AddProductBloc _addProductBloc;

  @override
  void initState() {
    _addProductBloc =
        AddProductBloc(addProductRepository: widget._addProductRepository);

    super.initState();
  }

  AddProductRepository provider = AddProductRepository();

  ProductTypeRepository productTypeRepository = ProductTypeRepository();

  String? types;

  Future<void> _showSnackbar() async {
    final snackBar = SnackBar(
      content: const Text('Product successfully added.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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

  Future<void> _alertInvalidProduct() async {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Product ID not found, please try again later.'),
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
          child: Center(
            child: Container(
              child: FormBuilder(
                key: _prodKey,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<AddProductBloc>(
                        create: (BuildContext context) => _addProductBloc),
                    BlocProvider<TypeProductBloc>(
                      create: (BuildContext context) => TypeProductBloc(
                          productTypeRepository: productTypeRepository),
                    ),
                  ],
                  child: Builder(
                    builder: (context) =>
                        BlocListener<AddProductBloc, AddProductState>(
                      listener: (context, state) {
                        if (state is AddProductLoading) {
                          _showLoading();
                        } else if (state is AddProductFailedById) {
                          Navigator.of(context).pop();
                          _alertInvalidProduct();
                        } else if (state is AddProductFailedByUid) {
                          Navigator.of(context).pop();
                          _alertInvalidUid();
                        } else if (state is AddProductFailedContentType) {
                          Navigator.of(context).pop();
                          _alertContentType();
                        } else if (state is AddProductFailedInternalServer) {
                          Navigator.of(context).pop();
                          _alertErrorServer();
                        } else if (state is AddProductFailedParam) {
                          Navigator.of(context).pop();
                          _alertErrorParam();
                        } else if (state is AddProductDone) {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed('/product');
                          _showSnackbar();
                        }
                      },
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
                          productPrice(context),
                          productName(context),
                          typeProductDropdown(),
                          uploadImage(),
                          addButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        child: FormBuilderTextField(
          name: 'price',
          decoration: InputDecoration(
            hintText: 'Price',
            prefixIcon: Icon(
              FontAwesomeIcons.tag,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.numeric(context),
            FormBuilderValidators.required(context),
          ]),
        ),
      ),
    );
  }

  Widget productName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        child: FormBuilderTextField(
          name: 'name',
          decoration: InputDecoration(
            hintText: 'Name',
            prefixIcon: Icon(
              FontAwesomeIcons.cubes,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ),
      ),
    );
  }

  Widget typeProductDropdown() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        child: BlocBuilder<TypeProductBloc, TypeProductState>(
            builder: (context, state) {
          if (state is TypeProductFailed) {
            print('Dropdown Error');
          } else if (state is TypeProductDone) {
            return ButtonTheme(
              alignedDropdown: true,
              child: FormBuilderDropdown(
                name: 'type',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.cubes,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                hint: Text('Select Type Product'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                items: state.type.map((ProductType item) {
                  return DropdownMenuItem(
                    child: Text('${item.type}'),
                    value: item.typeId,
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    if (newValue == 1) {
                      types = 'Drug & Healthcare';
                    } else if (newValue == 2) {
                      types = 'Food & Groceries';
                    } else if (newValue == 3) {
                      types = 'Electronics';
                    } else if (newValue == 4) {
                      types = 'Furniture & Houseware';
                    }
                  });
                },
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget uploadImage() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        child: FormBuilderFilePicker(
          name: 'image',
          decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.image,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              labelText: 'Image'),
          maxFiles: 1,
          previewImages: true,
          onChanged: (val) => print(val),
          withData: true,
          selector: Row(
            children: <Widget>[Icon(FontAwesomeIcons.upload)],
          ),
          onFileLoading: (val) {
            print('val');
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ),
      ),
    );
  }

  Widget addButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(280, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Color.fromRGBO(0, 209, 77, 1),
              width: 2,
            ),
          ),
          primary: Colors.white,
        ),
        onPressed: () {
          if (_prodKey.currentState!.saveAndValidate()) {
            _addProductBloc.add(NewProduct(
                typeId: _prodKey.currentState!.value['type'],
                name: _prodKey.currentState!.value['name'],
                price: _prodKey.currentState!.value['price'],
                imageType: (_prodKey.currentState!.value['image']
                        as List<PlatformFile>)
                    .first
                    .extension!,
                image64: (_prodKey.currentState!.value['image']
                        as List<PlatformFile>)
                    .first
                    .bytes!,
                firebaseUid:
                    BlocProvider.of<AuthenticationBloc>(context).user.uid));
          }
        },
        child: Text(
          'Add',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(0, 209, 77, 1),
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
  //         FormBuilderTextField(
  //           name: 'stock',
  //           decoration: InputDecoration(
  //             hintText: 'Stock',
  //             prefixIcon: Icon(
  //               FontAwesomeIcons.cubes,
  //               color: Colors.black,
  //             ),
  //           ),
  //           textInputAction: TextInputAction.next,
  //           validator: FormBuilderValidators.compose([
  //             FormBuilderValidators.numeric(context),
  //             FormBuilderValidators.required(context),
  //           ]),
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
  //         FormBuilderTextField(
  //           name: 'desc',
  //           decoration: InputDecoration(
  //             hintText: 'Description',
  //             prefixIcon: Icon(
  //               FontAwesomeIcons.alignJustify,
  //               color: Colors.black,
  //             ),
  //           ),
  //           textInputAction: TextInputAction.next,
  //           validator: FormBuilderValidators.compose([
  //             FormBuilderValidators.required(context),
  //           ]),
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
  //         FormBuilderTextField(
  //           name: 'warehouse',
  //           decoration: InputDecoration(
  //             hintText: 'Warehouse Sources',
  //             prefixIcon: Icon(
  //               FontAwesomeIcons.warehouse,
  //               color: Colors.black,
  //             ),
  //           ),
  //           textInputAction: TextInputAction.next,
  //           validator: FormBuilderValidators.compose([
  //             FormBuilderValidators.required(context),
  //           ]),
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
  //         FormBuilderTextField(
  //           name: 'address',
  //           decoration: InputDecoration(
  //             hintText: 'Warehouse Address',
  //             prefixIcon: Icon(
  //               FontAwesomeIcons.mapMarkerAlt,
  //               color: Colors.black,
  //             ),
  //           ),
  //           textInputAction: TextInputAction.next,
  //           validator: FormBuilderValidators.compose([
  //             FormBuilderValidators.required(context),
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
