part of 'all_product_bloc.dart';

abstract class AllProductState extends Equatable {
  const AllProductState();

  @override
  List<Object> get props => [];
}

class AllProductInitial extends AllProductState {}

class AllProductLoading extends AllProductState {}

class AllProductDone extends AllProductState {
  final AllProduct name;

  AllProductDone({required this.name});

  @override
  List<Object> get props => [
        name,
      ];
}

class AllProductFailed extends AllProductState {}

class AllProductFailedById extends AllProductFailed {}
