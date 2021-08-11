import 'dart:convert';

AllProduct allProductFromJson(String str) =>
    AllProduct.fromJson(json.decode(str));

String allProductToJson(AllProduct data) => json.encode(data.toJson());

class AllProduct {
  AllProduct({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["Product_ID"],
        productTypeId: json["Product_Type_ID"],
        imageUrl: json["Image_Url"] == null ? null : json["Image_Url"],
        productName: json["Product_Name"],
        singlePrice: json["Single_Price"],
        softDelete: json["Soft_Delete"],
      );

  Map<String, dynamic> toJson() => {
        "Product_ID": productId,
        "Product_Type_ID": productTypeId,
        "Image_Url": imageUrl == null ? null : imageUrl,
        "Product_Name": productName,
        "Single_Price": singlePrice,
        "Soft_Delete": softDelete,
      };
}
