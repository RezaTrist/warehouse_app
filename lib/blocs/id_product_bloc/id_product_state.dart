part of 'id_product_bloc.dart';

abstract class IdProductState extends Equatable {
  const IdProductState();

  @override
  List<Object> get props => [];
}

class IdProductInitial extends IdProductState {}

class IdProductLoading extends IdProductState {}

class IdProductDone extends IdProductState {
  final ProductById idProduct;

  IdProductDone({required this.idProduct});

  @override
  List<Object> get props => [
        idProduct,
      ];
}

class IdProductFailed extends IdProductState {}
