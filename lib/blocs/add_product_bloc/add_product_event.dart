part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class NewProduct extends AddProductEvent {
  final int typeId;
  final String name;
  final int price;
  final String imageType;
  final String image64;

  NewProduct({
    required this.typeId,
    required this.name,
    required this.price,
    required this.imageType,
    required this.image64,
  });
}
