
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.g.dart';
@JsonSerializable()
class Category{
  int? id;
  String? name;
  int? parent;
  Category({this.id,this.name,this.parent});
  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
}