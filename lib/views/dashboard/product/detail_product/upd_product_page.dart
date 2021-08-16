import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:warehouse_app/blocs/upd_product_bloc/update_product_bloc.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage(
      {Key? key, required UpdateProductRepository updateProductRepository})
      : _updateProductRepository = updateProductRepository,
        super(key: key);

  final UpdateProductRepository _updateProductRepository;

  @override
  _UpdateProductPage createState() => _UpdateProductPage();
}

class _UpdateProductPage extends State<UpdateProductPage> {
  final GlobalKey<FormBuilderState> _updateKey = GlobalKey();

  late UpdateProductBloc _updateProductBloc;

  @override
  void initState() {
    _updateProductBloc = UpdateProductBloc(
        updateProductRepository: widget._updateProductRepository);

    super.initState();
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
        onPressed: () {},
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(0, 209, 77, 1),
          ),
        ),
      ),
    );
  }
}
