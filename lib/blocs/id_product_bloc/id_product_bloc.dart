import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/product_model/id_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/product_id_repository.dart';

part 'id_product_event.dart';
part 'id_product_state.dart';

class IdProductBloc extends Bloc<IdProductEvent, IdProductState> {
  IdProductBloc({required this.productByIdRepository})
      : super(IdProductInitial());

  final ProductByIdRepository productByIdRepository;

  @override
  Stream<IdProductState> mapEventToState(
    IdProductEvent event,
  ) async* {
    if (event is LoadIdProduct) {
      yield IdProductLoading();
      try {
        final result = await productByIdRepository.getProductById(
            idProduct: event.productId);
        yield IdProductDone(productId: result);
      } on GetProductByIdFailureInvalidProductId {
        yield IdProductFailedById();
      } on GetProductByIdFailureServer {
        yield IdProductFailedInternalServer();
      } on GetProductByIdFailureParam {
        yield IdProductFailedParam();
      } catch (e) {
        yield IdProductFailed();
      }
    }
  }
}
