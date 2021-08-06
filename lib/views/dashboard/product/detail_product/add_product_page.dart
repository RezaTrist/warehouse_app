import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:warehouse_app/blocs/add_product_bloc/add_product_bloc.dart';
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

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormBuilderState> _prodKey = GlobalKey();

  late AddProductBloc _addProductBloc;

  // late File _image;

  // _imageFromCamera() async {
  //   XFile? image = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 50);

  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   }
  // }

  // _imageFromGallery() async {
  //   XFile? image = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50);

  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   }
  // }

  // void _showPicker(contect) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //             child: Wrap(
  //           children: [
  //             ListTile(
  //               leading: Icon(FontAwesomeIcons.solidImages),
  //               title: Text('Gallery'),
  //               onTap: () {
  //                 _imageFromGallery();
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(FontAwesomeIcons.camera),
  //               title: Text('Camera'),
  //               onTap: () {
  //                 _imageFromCamera();
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ));
  //       });
  // }

  @override
  void initState() {
    _addProductBloc =
        AddProductBloc(addProductRepository: widget._addProductRepository);
    super.initState();
  }

  AddProductRepository provider = AddProductRepository();

  ProductTypeRepository productTypeRepository = ProductTypeRepository();

  String? types;

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
            child: FormBuilder(
              key: _prodKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<AddProductBloc>(
                    create: (BuildContext context) =>
                        AddProductBloc(addProductRepository: provider),
                  ),
                  BlocProvider<TypeProductBloc>(
                    create: (BuildContext context) => TypeProductBloc(
                        productTypeRepository: productTypeRepository),
                  ),
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
                    productPrice(context),
                    productName(context),
                    typeProductDropdown(),
                    uploadImage(),
                    // productLeft(),
                    // productStock(),
                    // productDescription(),
                    // warehouseSources(),
                    // warehouseAddress(),
                    addButton(),
                  ],
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
          selector: Row(
            children: <Widget>[Icon(FontAwesomeIcons.upload), Text('Upload')],
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
          _prodKey.currentState!.saveAndValidate();
          if (_prodKey.currentState!.validate()) {
            print(_prodKey.currentState!.value['price']);
            print(_prodKey.currentState!.value['name']);
            print(_prodKey.currentState!.value['type']);
            print(_prodKey.currentState!.value['image']);
            // print(_prodKey.currentState!.value['stock']);
            // print(_prodKey.currentState!.value['desc']);
            // print(_prodKey.currentState!.value['warehouse']);
            // print(_prodKey.currentState!.value['address']);
          }
        },
        child: Text(
          'Add',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(0, 209, 77, 1),
          ),
        ),
      ),
    );
  }
}
