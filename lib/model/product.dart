import 'package:slash_task/model/product_property.dart';
import 'package:slash_task/model/product_variation.dart';

import 'brand.dart';

class Product {
  int? id;
  String? name;
  String? description;
  int? brandId;
  Brand? brand;
  String? brandName;
  String? brandImage;
  String? brandLogoUrl;
  List<ProductVariation>? variations;
  List<AvaiableProperties>? avaiableProperties;

  Product({
    this.id,
    this.name,
    this.description,
    this.brandId,
    this.brand,
    this.brandName,
    this.brandLogoUrl,
    this.variations,
    this.avaiableProperties,
    this.brandImage
  });

   Product.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     name = json['name'];
     description = json['description'];
     brandId = json['brand_id'];
     brandName = json['brandName'];
     brandImage = json['brandImage'];
     brandLogoUrl = json['brandImage'];
     brand =
    json['Brands'] != null ? Brand.fromJson(json['Brands']) : null;
    if (json['ProductVariations'] != null) {
      variations = <ProductVariation>[];
      json['ProductVariations'].forEach((v) {
        variations!.add(ProductVariation.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = <ProductVariation>[];
      json['variations'].forEach((v) {
        variations!.add(ProductVariation.fromJson(v));
      });
    }
    if (json['avaiableProperties'] != null) {
      avaiableProperties = <AvaiableProperties>[];
      json['avaiableProperties'].forEach((v) {
        avaiableProperties!.add(AvaiableProperties.fromJson(v));
      });
    }
  }
}
