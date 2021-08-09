class AddProduct {
  final int typeId;
  final String name;
  final String price;
  final ImageProduct image;
  // final String firebaseUid;
  // final String imageType;
  // final String image64;

  const AddProduct({
    required this.typeId,
    required this.name,
    required this.price,
    required this.image,
    // required this.firebaseUid,
    // required this.imageType,
    // required this.image64,
  });

  Map<String, dynamic> toJson() {
    return {
      'Product_Type_ID': typeId,
      'Product_Name': name,
      'Single_Price': price,
      'Image': image,
      // 'mime': imageType,
      // 'data': image64,
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
