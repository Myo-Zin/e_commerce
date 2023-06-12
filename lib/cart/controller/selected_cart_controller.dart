import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item.dart';

class SelectedCartListNotifier extends StateNotifier<List<CartItem>> {
  final List<CartItem> list;

  SelectedCartListNotifier(this.list) : super(list);
}



