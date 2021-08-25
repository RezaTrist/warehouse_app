part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class DisableProduct extends DeleteProductEvent {
  // final bool softDelete;
  final int productId;
  final String firebaseUid;

  DisableProduct({
    // required this.softDelete,
    required this.productId,
    required this.firebaseUid,
  });

  @override
  List<Object> get props => [
        // softDelete,
        productId,
        firebaseUid,
      ];
}
