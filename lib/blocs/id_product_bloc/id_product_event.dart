part of 'id_product_bloc.dart';

abstract class IdProductEvent extends Equatable {
  const IdProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductById extends IdProductEvent {
  const LoadProductById();

  @override
  List<Object> get props => [];
}
