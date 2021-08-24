import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/add_product_repository.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc({required this.addProductRepository})
      : super(AddProductState());

  final AddProductRepository addProductRepository;

  @override
  Stream<AddProductState> mapEventToState(
    AddProductEvent event,
  ) async* {
    if (event is NewProduct) {
      yield AddProductLoading();
      try {
        Uint8List imageToUploadBytes = event.image64;
        String image64 = base64Encode(imageToUploadBytes);
        print(event.imageType);

        ImageProduct image =
            ImageProduct(imageType: event.imageType, image64: image64);

        await addProductRepository.addProduct(
          typeId: event.typeId,
          name: event.name,
          price: event.price,
          image: image,
          firebaseUid: event.firebaseUid,
        );
        yield AddProductDone();
      } on GetAddProductFailureInvalidUid {
        yield AddProductFailedByUid();
      } on GetAddProductFailureInvalidId {
        yield AddProductFailedById();
      } on GetAddProductFailureParam {
        yield AddProductFailedParam();
      } on GetAddProductFailureContentType {
        yield AddProductFailedContentType();
      } on GetAddProductFailureServer {
        yield AddProductFailedInternalServer();
      }
      // catch (e) {
      //   yield AddProductFailed();
      // }
    }
  }
}
