import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/repo/repositories/product_repo/del_product_repository.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductBloc({required this.deleteProductRepository})
      : super(DeleteProductInitial());

  final DeleteProductRepository deleteProductRepository;

  @override
  Stream<DeleteProductState> mapEventToState(
    DeleteProductEvent event,
  ) async* {
    if (event is DisableProduct) {
      yield DeleteProductLoading();
      try {
        await deleteProductRepository.deleteProductById(
          idProduct: event.productId,
          firebaseUid: event.firebaseUid,
        );
        yield DeleteProductDone();
      } on DeleteProductFailureProductId {
        yield DeleteProductFailedById();
      } on DeleteProductFailureUid {
        yield DeleteProductFailedUid();
      } on DeleteProductFailureServer {
        yield DeleteProductFailedInternalServer();
      }
      // catch (e) {
      //   yield DeleteProductFailed();
      // }
    }
  }
}
