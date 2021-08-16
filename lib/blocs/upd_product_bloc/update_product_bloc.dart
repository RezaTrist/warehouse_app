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
        Uint8List imageToUploadBytes = event.image64;
        String image64 = base64Encode(imageToUploadBytes);
        print(event.imageType);

        ImageProduct image =
            ImageProduct(imageType: event.imageType, image64: image64);

        await updateProductRepository.updateProduct(
          typeId: event.typeId,
          name: event.name,
          price: event.price,
          image: image,
          firebaseUid: event.firebaseUid,
        );
        yield UpdateProductDone();
      } catch (e) {
        yield UpdateProductFailed();
      }
    }
  }
}
