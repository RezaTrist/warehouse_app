part of 'update_product_bloc.dart';

abstract class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductDone extends UpdateProductState {}

class UpdateProductFailed extends UpdateProductState {}

class UpdateProductFailedByUid extends UpdateProductFailed {}

class UpdateProductFailedById extends UpdateProductFailed {}

class UpdateProductFailedContentType extends UpdateProductFailed {}

class UpdateProductFailedParam extends UpdateProductFailed {}

class UpdateProductFailedInternalServer extends UpdateProductFailed {}
