part of 'update_product_bloc.dart';

abstract class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductDone extends UpdateProductState {
  // final IdProduct productId;

  // UpdateProductDone({required this.productId});

  // @override
  // List<Object> get props => [
  //       productId,
  //     ];
}

class UpdateProductFailed extends UpdateProductState {}
