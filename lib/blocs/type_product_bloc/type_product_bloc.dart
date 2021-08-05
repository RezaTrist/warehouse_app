import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/product_model/type_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/type_product_repository.dart';

part 'type_product_event.dart';
part 'type_product_state.dart';

class TypeProductBloc extends Bloc<TypeProductEvent, TypeProductState> {
  TypeProductBloc({required this.productTypeRepository})
      : super(TypeProductInitial()) {
    add(LoadType(amount: 4));
  }

  final ProductTypeRepository productTypeRepository;

  @override
  Stream<TypeProductState> mapEventToState(
    TypeProductEvent event,
  ) async* {
    if (event is LoadType) {
      yield TypeProductLoading();
      try {
        final result =
            await productTypeRepository.getProductType(amount: event.amount);
        yield TypeProductDone(type: result);
      } catch (e) {
        yield TypeProductFailed();
      }
    }
  }
}
