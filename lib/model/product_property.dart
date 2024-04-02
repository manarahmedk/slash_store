class ProductProperty {
  final String value;
  final String property;

  ProductProperty({required this.value, required this.property});

  factory ProductProperty.fromJson(Map<String, dynamic> json) {
    final value = json['value'];
    final property = json['property'];
    return ProductProperty(value: value,property:property );
  }

}

class AvaiableProperties {
  final String property;
  final List<Property> values;

  AvaiableProperties({required this.property,required this.values});

  factory AvaiableProperties.fromJson(Map<String, dynamic> json) {
    final property = json['property'];
    final values = <Property>[];
    if (json['values'] != null) {
      json['values'].forEach((v) {
        values.add(Property.fromJson(v));
      });
    }
    return AvaiableProperties(property: property,values: values);
  }
}

class Property {
  final String value;
  final int id;

  Property({required this.value,required this.id});

  factory Property.fromJson(Map<String, dynamic> json) {
    final value = json['value'];
    final id = json['id'];
    return Property(value: value, id: id);
  }

}