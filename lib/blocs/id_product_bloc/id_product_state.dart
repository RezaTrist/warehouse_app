part of 'id_product_bloc.dart';

abstract class IdProductState extends Equatable {
  const IdProductState();

  @override
  List<Object> get props => [];
}

class IdProductInitial extends IdProductState {}

class IdProductLoading extends IdProductState {}

class IdProductFailed extends IdProductState {}

class IdProductFailedById extends IdProductState {}

class IdProductDone extends IdProductState {
  final IdProduct productId;

  IdProductDone({required this.productId});

  @override
  List<Object> get props => [
        productId,
      ];
}
