class UploadImage {
  final String imageType;
  final String image64;

  const UploadImage({
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
