part of 'id_product_bloc.dart';

abstract class IdProductEvent extends Equatable {
  const IdProductEvent();

  @override
  List<Object> get props => [];
}

class LoadIdProduct extends IdProductEvent {
  final int productId;

  LoadIdProduct({required this.productId});

  @override
  List<Object> get props => [
        productId,
      ];
}
