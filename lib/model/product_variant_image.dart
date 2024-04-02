class ProductVariantImage {
  int? id;
  String? imagePath;
  int? productVariantId;

  ProductVariantImage({
    this.id,
    this.imagePath,
    this.productVariantId,
  });

  ProductVariantImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    productVariantId = json['product_varient_id'];
    //print(imagePath);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_path'] = imagePath;
    data['product_varient_id'] = productVariantId;
    return data;
  }
}
