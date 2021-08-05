class ProductTypePack {
  final String message;
  final List<ProductType> data;

  ProductTypePack({required this.message, required this.data});

  factory ProductTypePack.fromJson(Map<String, dynamic> json) {
    List<ProductType> _temp = [];

    for (Map<String, dynamic> type in json['data']) {
      _temp.add(ProductType.fromJson(type));
    }
    return ProductTypePack(
      message: json['message'],
      data: _temp,
    );
  }
}

class ProductType {
  final int typeId;
  final String type;

  ProductType({
    required this.typeId,
    required this.type,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      typeId: json['Product_Type_ID'],
      type: json['Product_Type_Name'],
    );
  }
}
