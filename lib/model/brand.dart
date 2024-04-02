class Brand {
  int? id;
  String? brandName;
  String? brandLogoImagePath;

  Brand({
    this.id,
    this.brandName,
    this.brandLogoImagePath,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandLogoImagePath = json['brand_logo_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_name'] = brandName;
    data['brand_logo_image_path'] = brandLogoImagePath;
    return data;
  }
}
