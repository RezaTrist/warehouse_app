import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/product_model/add_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/upd_product_repository.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc({required this.updateProductRepository})
      : super(UpdateProductInitial());

  final UpdateProductRepository updateProductRepository;

  @override
  Stream<UpdateProductState> mapEventToState(
    UpdateProductEvent event,
  ) async* {
    if (event is UpdateProduct) {
      yield UpdateProductLoading();
      try {
        ImageProduct? image;
        // String imageType;
        // String image64;
        if (event.image64 == null && event.imageType == null) {
          image = null;
        } else if (event.image64 != null && event.imageType != null) {
          image = ImageProduct(
              imageType: event.imageType,
              image64: base64Encode(event.image64!));
        } else {
          yield UpdateProductFailed();
          throw Exception();
        }

        // ImageProduct image =
        //     ImageProduct(imageType: imageType, image64: image64);

        await updateProductRepository.updateProduct(
            typeId: event.typeId,
            name: event.name,
            price: event.price,
            image: image,
            firebaseUid: event.firebaseUid,
            idProduct: event.productId);

        yield UpdateProductDone();
      } on UpdateProductFailureInvalidUid {
        yield UpdateProductFailedByUid();
      } on UpdateProductFailureInvalidId {
        yield UpdateProductFailedById();
      } on UpdateProductFailureParam {
        yield UpdateProductFailedParam();
      } on UpdateProductFailureContentType {
        yield UpdateProductFailedContentType();
      } on UpdateProductFailureServer {
        yield UpdateProductFailedInternalServer();
      }
      // catch (e) {
      //   yield UpdateProductFailed();
      // }
    }
  }
}
