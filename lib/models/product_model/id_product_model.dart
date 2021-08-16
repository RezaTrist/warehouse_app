import 'dart:convert';

IdProduct idProductFromJson(String str) => IdProduct.fromJson(json.decode(str));

String idProductToJson(IdProduct data) => json.encode(data.toJson());

class IdProduct {
  IdProduct({
    this.message,
    this.data,
  });

  String? message;
  ProductDataById? data;

  factory IdProduct.fromJson(Map<String, dynamic> json) => IdProduct(
        message: json["message"],
        data: ProductDataById.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class ProductDataById {
  ProductDataById(
      {this.productId,
      this.productTypeId,
      this.imageUrl,
      this.productName,
      this.singlePrice,
      this.softDelete,
      this.productTypeName});

  int? productId;
  int? productTypeId;
  String? imageUrl;
  String? productName;
  int? singlePrice;
  bool? softDelete;
  String? productTypeName;

  factory ProductDataById.fromJson(Map<String, dynamic> json) =>
      ProductDataById(
        productId: json["Product_ID"],
        productTypeId: json["Product_Type_ID"],
        imageUrl: json["Image_Url"],
        productName: json["Product_Name"],
        singlePrice: json["Single_Price"],
        softDelete: json["Soft_Delete"],
        productTypeName: json['Product_Type_Name'],
      );

  Map<String, dynamic> toJson() => {
        "Product_ID": productId,
        "Product_Type_ID": productTypeId,
        "Image_Url": imageUrl,
        "Product_Name": productName,
        "Single_Price": singlePrice,
        "Soft_Delete": softDelete,
        "Product_Type_Name": productTypeName,
      };
}
