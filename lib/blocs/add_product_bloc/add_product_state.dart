part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductDone extends AddProductState {}

// class AddProductFailed extends AddProductState {}

class AddProductFailedByUid extends AddProductState {}

class AddProductFailedById extends AddProductState {}

class AddProductFailedContentType extends AddProductState {}

class AddProductFailedParam extends AddProductState {}

class AddProductFailedInternalServer extends AddProductState {}
