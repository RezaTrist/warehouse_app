import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        await addProductRepository.addProduct(
          typeId: event.typeId,
          name: event.name,
          price: event.price,
          imageType: event.imageType,
          image64: event.image64,
        );
        yield AddProductDone();
      } catch (e) {
        yield AddProductFailed();
      }
    }
  }
}
