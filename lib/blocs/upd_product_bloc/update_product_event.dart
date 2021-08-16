part of 'update_product_bloc.dart';

abstract class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProduct extends UpdateProductEvent {
  final int typeId;
  final String name;
  final String price;
  final String imageType;
  final Uint8List image64;
  final String firebaseUid;
  // final int productId;

  UpdateProduct({
    required this.typeId,
    required this.name,
    required this.price,
    required this.imageType,
    required this.image64,
    required this.firebaseUid,
    // required this.productId,
  });

  @override
  List<Object> get props => [
        typeId,
        name,
        price,
        imageType,
        image64,
        firebaseUid,
        // productId,
      ];
}
