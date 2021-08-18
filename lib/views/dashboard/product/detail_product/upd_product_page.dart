import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:warehouse_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_app/blocs/id_product_bloc/id_product_bloc.dart';
import 'package:warehouse_app/blocs/type_product_bloc/type_product_bloc.dart';
import 'package:warehouse_app/models/product_model/type_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/product_id_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/type_product_repository.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';
import 'package:warehouse_app/blocs/upd_product_bloc/update_product_bloc.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage(
      {Key? key,
      required this.productId,
      required UpdateProductRepository updateProductRepository})
      : _updateProductRepository = updateProductRepository,
        super(key: key);

  final int productId;

  final UpdateProductRepository _updateProductRepository;

  @override
  _UpdateProductPage createState() => _UpdateProductPage();
}

class _UpdateProductPage extends State<UpdateProductPage> {
  final GlobalKey<FormBuilderState> _updateKey = GlobalKey();

  late UpdateProductBloc _updateProductBloc;

  late IdProductBloc idProductBloc;

  ProductByIdRepository productByIdRepository = ProductByIdRepository();

  ProductTypeRepository productTypeRepository = ProductTypeRepository();

  UpdateProductRepository updateProductRepository = UpdateProductRepository();

  String? types;

  void initState() {
    idProductBloc = IdProductBloc(productByIdRepository: productByIdRepository);
    _updateProductBloc = UpdateProductBloc(
        updateProductRepository: widget._updateProductRepository);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    idProductBloc.add(LoadIdProduct(productId: widget.productId));
    super.didChangeDependencies();
  }

  Future<void> _showSnackbar() async {
    final snackBar = SnackBar(
      content: const Text('Product successfully updated.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text('Are you sure to save this changes?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(context),
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_updateKey.currentState!.saveAndValidate()) {
                        _updateProductBloc.add(UpdateProduct(
                            typeId: _updateKey.currentState!.value['type'],
                            name: _updateKey.currentState!.value['name'],
                            price: _updateKey.currentState!.value['price'],
                            imageType: (_updateKey.currentState!.value['image']
                                    as List<PlatformFile>)
                                .first
                                .extension!,
                            image64: (_updateKey.currentState!.value['image']
                                    as List<PlatformFile>)
                                .first
                                .bytes!,
                            firebaseUid:
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .user
                                    .uid,
                            productId: widget.productId));
                      }
                      Navigator.of(context).pushNamed('/product');
                      _showSnackbar();
                    },
                    child: Text('Yes'),
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
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 209, 77, 1),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FormBuilder(
          key: _updateKey,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => idProductBloc),
              BlocProvider<TypeProductBloc>(
                create: (BuildContext context) => TypeProductBloc(
                    productTypeRepository: productTypeRepository),
              ),
              BlocProvider(
                create: (BuildContext context) => _updateProductBloc,
              )
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
                        'Edit Product',
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
                saveButton(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget productPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: BlocBuilder<IdProductBloc, IdProductState>(
        builder: (context, state) {
          if (state is IdProductDone) {
            return Container(
              child: FormBuilderTextField(
                name: 'price',
                decoration: InputDecoration(
                  hintText: '${state.productId.data!.singlePrice}',
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
            );
          }
          return Container();
        },
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
      child: BlocBuilder<IdProductBloc, IdProductState>(
        builder: (context, state) {
          if (state is IdProductDone) {
            return Container(
              child: FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                  hintText: '${state.productId.data!.productName}',
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
            );
          }
          return Container();
        },
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
          if (state is TypeProductDone) {
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
                hint: BlocBuilder<IdProductBloc, IdProductState>(
                  builder: (context, state) {
                    if (state is IdProductDone) {
                      return Text('${state.productId.data!.productTypeName}');
                    }
                    return Container();
                  },
                ),
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

  Widget saveButton() {
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
        onPressed: () {
          _showAlertDialog();
          // if (_updateKey.currentState!.saveAndValidate()) {
          //   _updateProductBloc.add(UpdateProduct(
          //       typeId: _updateKey.currentState!.value['type'],
          //       name: _updateKey.currentState!.value['name'],
          //       price: _updateKey.currentState!.value['price'],
          //       imageType: (_updateKey.currentState!.value['image']
          //               as List<PlatformFile>)
          //           .first
          //           .extension!,
          //       image64: (_updateKey.currentState!.value['image']
          //               as List<PlatformFile>)
          //           .first
          //           .bytes!,
          //       firebaseUid:
          //           BlocProvider.of<AuthenticationBloc>(context).user.uid,
          //       productId: widget.productId));
          // }
        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(35, 42, 255, 1),
          ),
        ),
      ),
    );
  }
}
