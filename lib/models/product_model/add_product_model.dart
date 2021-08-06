class AddProduct {
  final int typeId;
  final String name;
  final String price;
  final String imageType;
  final String image64;

  const AddProduct({
    required this.typeId,
    required this.name,
    required this.price,
    required this.imageType,
    required this.image64,
  });

  Map<String, dynamic> toJson() {
    return {
      'Product_Type_ID': typeId,
      'Product_Name': name,
      'Single_Price': price,
      'mime': imageType,
      'data': image64,
    };
  }
}
