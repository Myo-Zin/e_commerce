import 'image.dart';

class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
    this.parent,
    this.image,
  });

  ProductCategory.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  int? id;
  String? name;
  int? parent;
  Image? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['parent'] = parent;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}
