class AddProduct {
  final int typeId;
  final String name;
  final String price;
  final ImageProduct image;

  const AddProduct({
    required this.typeId,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'Product_Type_ID': typeId,
      'Product_Name': name,
      'Single_Price': price,
      'Image': image,
    };
  }
}

class ImageProduct {
  final String? imageType;
  final String? image64;

  const ImageProduct({
    required this.imageType,
    required this.image64,
  });

  Map<String, dynamic> toJson() {
    return {
      'mime': imageType,
      'data': image64,
    };
  }
}
