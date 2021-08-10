import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/product_model/all_product_model.dart';
import 'package:warehouse_app/repo/repositories/product_repo/all_product_repository.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  AllProductBloc({required this.allProductRepository})
      : super(AllProductInitial()) {
    add(LoadAllProduct());
  }

  final AllProductRepository allProductRepository;

  @override
  Stream<AllProductState> mapEventToState(
    AllProductEvent event,
  ) async* {
    if (event is LoadAllProduct) {
      yield AllProductLoading();
      try {
        final result = await allProductRepository.getAllProduct();
        yield AllProductDone(name: result);
      } catch (e) {
        yield AllProductFailed();
      }
    }
  }
}
