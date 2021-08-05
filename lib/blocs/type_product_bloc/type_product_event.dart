part of 'type_product_bloc.dart';

abstract class TypeProductEvent extends Equatable {
  const TypeProductEvent();

  @override
  List<Object> get props => [];
}

class LoadType extends TypeProductEvent {
  final int amount;

  LoadType({int? amount}) : amount = amount ?? 4;

  @override
  List<Object> get props => [
        amount,
      ];
}
