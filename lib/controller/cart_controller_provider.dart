import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/data_model.dart';
import '../data/local/database_service.dart';

class CartNotifier extends StateNotifier<List<DataModel>>{
  CartNotifier(this._database):super ([]){
    getAllCarts();
  }


  late final DatabaseService _database;

  Future<void> addCart(DataModel dataModel) async {
    await _database.addCart(dataModel);
    getAllCarts();
  }


  Future<void> deleteCart(int index) async {
    await _database.deleteCart(index);
    getAllCarts();
  }

  Future<void> deleteAllCart() async {
    await _database.deleteAllCart();
    getAllCarts();
  }

  Future<void> updateCart(int index, DataModel dataModel) async {
    await _database.updateCart(index, dataModel);
    getAllCarts();

  }

  void getAllCarts() async {
   final cartResults = _database.getAllCart()??[];
    state = cartResults;
  }
  int getGrandTotal()   {
    //getAllCarts();
    int total = 0;
      state =  _database.cartBox.values.toList();
      for (var element in state) {
        if (element.isCheck) {
          total += int.parse(element.subtotal.toString());
        }
      }
    //   for (int i = 0; i < cartList.length; i++) {
    //   if (cartList[i].isCheck) {
    //     total += int.parse(cartList[i].subtotal.toString());
    //   }
    // }
    return total;
    return _database.getGrandTotal();
  }
  List<DataModel> getSelectedCart()  => _database.getSelectedCart();

}

final cartControllerProvider =  StateNotifierProvider<CartNotifier,List<DataModel>>((ref) {
  final database = ref.watch(databaseService);
  return CartNotifier(database);
});