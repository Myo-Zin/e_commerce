
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String quantity;

  @HiveField(5)
  final List<LocalImage> images;

  @HiveField(6)
  final bool isCheck;

  @HiveField(7)
  final int subtotal;

  DataModel( {required this.id,required this.name,required this.price, required this.description, required this.quantity,required this.images,required this.isCheck,required this.subtotal,});

}
@HiveType(typeId: 1)
class LocalImage{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String src;
  LocalImage({required this.id,required this.src});
}
