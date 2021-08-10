class AllProductPack {
  final String message;
  final List<AllProduct> data;

  AllProductPack({required this.message, required this.data});

  factory AllProductPack.fromJson(Map<String, dynamic> json) {
    List<AllProduct> _temp = [];
    for (Map<String, dynamic> name in json['data']) {
      _temp.add(AllProduct.fromJson(name));
    }
    return AllProductPack(
      message: json['message'],
      data: _temp,
    );
  }
}

class AllProduct {
  final int productId;
  final int typeId;
  final String image;
  final String name;
  final String price;
  final bool delete;

  AllProduct({
    required this.productId,
    required this.typeId,
    required this.image,
    required this.name,
    required this.price,
    required this.delete,
  });

  factory AllProduct.fromJson(Map<String, dynamic> json) {
    return AllProduct(
      productId: json['Product_ID'],
      typeId: json['Product_Type_ID'],
      image: json['Image_url'],
      name: json['Product_Name'],
      price: json['Single_Price'],
      delete: json['Soft_Delete'],
    );
  }
}
