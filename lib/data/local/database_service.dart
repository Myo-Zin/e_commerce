import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants.dart';
import 'data_model.dart';

final databaseService = Provider<DatabaseService>((_) => DatabaseService());

class DatabaseService {
  late final Box<DataModel> cartBox;

  Future<void> initTheme() async {
    await Hive.openBox<DataModel>(cartBoxName).then((value) => cartBox = value);
  }

  Future<void> addCart(DataModel dataModel) async =>
      await cartBox.add(dataModel);

  Future<void> deleteCart(int index) async => await cartBox.deleteAt(index);

  Future<void> deleteAllCart() async => await cartBox.clear();


  Future<void> updateCart(int index, DataModel dataModel) async =>
      await cartBox.putAt(index, dataModel);

  List<DataModel>? getAllCart() => cartBox.values.toList();

  int getGrandTotal() {
    int total = 0;
    List<DataModel> cartList =  cartBox.values.toList();
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].isCheck) {
        total += int.parse(cartList[i].subtotal.toString());
      }
    }
    return total;
  }

  List<DataModel> getSelectedCart() {
    List<DataModel> list = [];
    List<DataModel> cartList =  cartBox.values.toList();
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].isCheck) {
        list.add(cartList[i]);
      }
    }
    return list;
  }
}
