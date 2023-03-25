import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityController =
StateNotifierProvider.autoDispose<Quantity, int>((ref) => Quantity());

class Quantity extends StateNotifier<int> {
  Quantity() : super(1);

  void increment() => state++;

  void decrement() {
    if (state > 1) {
      state--;
    }
  }
}