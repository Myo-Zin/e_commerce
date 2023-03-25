import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category.dart';
import '../repository/repository.dart';

final allCategoriesListController = FutureProvider<List<Category>>((ref) async {
  final result = ref.read(repositoryProvider).getAllCategories();
  return result;
});

final slugIdStateProvider = StateProvider<List<Category>>((ref) => []);
final slugIdController = Provider((ref) => SlugIdController(ref));

class SlugIdController {
  final Ref ref;
  SlugIdController(this.ref);

  void getSlugId(String slug) {
    try{
      final result = ref.watch(repositoryProvider).getSlugId(slug);
      result.then((value) => ref.read(slugIdStateProvider.notifier).state = value );

    }on DioError catch(e){
      final error = e.response== null
          ? "something went wrong!"
          : e.response?.data['message'] ?? "something went wrong!";
      ref.read(slugIdStateProvider.notifier).state = error;
    }
  }
}
