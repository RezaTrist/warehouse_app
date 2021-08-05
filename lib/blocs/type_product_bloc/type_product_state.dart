part of 'type_product_bloc.dart';

abstract class TypeProductState extends Equatable {
  const TypeProductState();

  @override
  List<Object> get props => [];
}

class TypeProductInitial extends TypeProductState {}

class TypeProductLoading extends TypeProductState {}

class TypeProductDone extends TypeProductState {
  final List<ProductType> type;

  TypeProductDone({required this.type});

  @override
  List<Object> get props => [
        type,
      ];
}

class TypeProductFailed extends TypeProductState {}
