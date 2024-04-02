import 'package:slash_task/model/product_property.dart';
import 'package:slash_task/model/product_variant_image.dart';

class ProductVariation {
  int? id;
  int? productId;
  num? price;
  int? quantity;
  bool? isDefault;
  List<ProductVariantImage> productVariantImages= <ProductVariantImage>[];
  List<ProductProperty>? productPropertiesValues;

  ProductVariation({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.isDefault,
    required this.productVariantImages,
    this.productPropertiesValues,
  });

  ProductVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'];
    isDefault = json['isDefault'];
    if (json['ProductVarientImages'] != null) {
      productVariantImages = <ProductVariantImage>[];
      json['ProductVarientImages'].forEach((v) {
        productVariantImages.add(ProductVariantImage.fromJson(v));
      });
    }

    if (json['productPropertiesValues'] != null) {
      productPropertiesValues = <ProductProperty>[];
      json['productPropertiesValues'].forEach((v) {
        productPropertiesValues!.add(ProductProperty.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['is_default'] = isDefault;
    data['productVariantImages'] = productVariantImages;
    return data;
  }
}
