import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormBuilderState> _prodKey = GlobalKey();
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
                  productPrice(),
                  productName(),
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
          FormBuilderTextField(
            name: 'price',
            decoration: InputDecoration(
              hintText: 'Price',
              prefixIcon: Icon(
                FontAwesomeIcons.tag,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(context),
              FormBuilderValidators.required(context),
            ]),
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
          FormBuilderTextField(
            name: 'name',
            decoration: InputDecoration(
              hintText: 'Name',
              prefixIcon: Icon(
                FontAwesomeIcons.cubes,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
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

  Widget productStock() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormBuilderTextField(
            name: 'stock',
            decoration: InputDecoration(
              hintText: 'Stock',
              prefixIcon: Icon(
                FontAwesomeIcons.cubes,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(context),
              FormBuilderValidators.required(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget productDescription() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormBuilderTextField(
            name: 'desc',
            decoration: InputDecoration(
              hintText: 'Description',
              prefixIcon: Icon(
                FontAwesomeIcons.alignJustify,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget warehouseSources() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormBuilderTextField(
            name: 'warehouse',
            decoration: InputDecoration(
              hintText: 'Warehouse Sources',
              prefixIcon: Icon(
                FontAwesomeIcons.warehouse,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget warehouseAddress() {
    return Card(
      color: Color.fromRGBO(226, 226, 226, 1),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // const ListTile(
          //   leading: Icon(
          //     FontAwesomeIcons.mapMarkerAlt,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     'Jl. Limo No.40, RT.8/RW.10, Grogol Sel., Kec. Kby. Lama, Kota Jakarta Selatan',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
          FormBuilderTextField(
            name: 'address',
            decoration: InputDecoration(
              hintText: 'Warehouse Address',
              prefixIcon: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Colors.black,
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
        ],
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
          fixedSize: Size(320, 45),
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
            print(_prodKey.currentState!.value['stock']);
            print(_prodKey.currentState!.value['desc']);
            print(_prodKey.currentState!.value['warehouse']);
            print(_prodKey.currentState!.value['address']);
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
