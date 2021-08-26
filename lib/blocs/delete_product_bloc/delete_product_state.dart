part of 'delete_product_bloc.dart';

abstract class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductLoading extends DeleteProductState {}

class DeleteProductDone extends DeleteProductState {}

// class DeleteProductFailed extends DeleteProductState {}

class DeleteProductFailedById extends DeleteProductState {}

class DeleteProductFailedInternalServer extends DeleteProductState {}

class DeleteProductFailedUid extends DeleteProductState {}
