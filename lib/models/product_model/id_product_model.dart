import 'dart:convert';

ProductById productByIdFromJson(String str) =>
    ProductById.fromJson(json.decode(str));

String productByIdToJson(ProductById data) => json.encode(data.toJson());

class ProductById {
  ProductById({
    this.message,
    this.data,
  });

  String? message;
  ProductDataId? data;

  factory ProductById.fromJson(Map<String, dynamic> json) => ProductById(
        message: json["message"],
        data: ProductDataId.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class ProductDataId {
  ProductDataId({
    this.productId,
    this.productTypeId,
    this.imageUrl,
    this.productName,
    this.singlePrice,
    this.softDelete,
  });

  int? productId;
  int? productTypeId;
  String? imageUrl;
  String? productName;
  int? singlePrice;
  bool? softDelete;

  factory ProductDataId.fromJson(Map<String, dynamic> json) => ProductDataId(
        productId: json["Product_ID"],
        productTypeId: json["Product_Type_ID"],
        imageUrl: json["Image_Url"],
        productName: json["Product_Name"],
        singlePrice: json["Single_Price"],
        softDelete: json["Soft_Delete"],
      );

  Map<String, dynamic> toJson() => {
        "Product_ID": productId,
        "Product_Type_ID": productTypeId,
        "Image_Url": imageUrl,
        "Product_Name": productName,
        "Single_Price": singlePrice,
        "Soft_Delete": softDelete,
      };
}
