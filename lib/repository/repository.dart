import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/network.dart';
import '../model/category.dart';
import '../model/order.dart';
import '../model/product.dart';

final repositoryProvider = Provider<Repository>(
  (ref) {
    return Repository(ref);
  },
);

class Repository {
  Repository(this.ref);

  final Ref ref;

  Future<List<Product>> getProductBanner() async {
    final queryParam = {
      "featured": true,
    };
    List<Product> _list = [];
    final dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('/products', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          _list.add(Product.fromJson(e));
        });
      }
      return _list;
    } on DioError catch(ex) {
      if(ex.type == DioErrorType.connectionTimeout){
        throw Exception("Connection Timeout");
      }
      rethrow;
    }
  }

  Future<List<Product>> getAllProduct(int page) async {
    final queryParam = {"page": page, "per_page": 20};
    List<Product> list = [];
    final dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('/products', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Product.fromJson(e));
        });
      }
      return list;
    } on DioError catch(ex) {
      if(ex.type == DioErrorType.connectionTimeout){
        throw Exception("Connection Timeout");
      }
      rethrow;
    }
  }

  Future<Order> orderProduct(Order order) async {
    final dio = ref.watch(dioProvider);

    try {
      final response = await dio.post('/orders', data: order.toJson());
      //if (response.statusCode == 200 && response.data != null) {
      return Order.fromJson(response.data);
      // }
      // else {
      //   throw Exception(response.data);
      // }
    } on DioError catch(ex) {
      if(ex.type == DioErrorType.connectionTimeout){
        throw Exception("Connection Timeout");
      }
      rethrow;
    }
  }

  Future<List<Category>> getAllCategories() async {
    final dio = ref.watch(dioProvider);
    List<Category> list = [];
    try {
      final response = await dio.get('/products/categories');
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Category.fromJson(e));
        });
      }
      return list;
    } on DioError catch(ex) {
      if(ex.type == DioErrorType.connectionTimeout){
        throw Exception("Connection Timeout");
      }
      rethrow;
    }
  }

  Future<List<Product>> getAllProductByCategoryId(int page,int categoryId) async {
    final queryParam = {"category": categoryId,"page": page, "per_page": 20};
    List<Product> list = [];
    final dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('/products', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Product.fromJson(e));
        });
      }
      return list;
    } on DioError {
      rethrow;
    }
  }

  Future<List<Product>> getAllProductBySearch(int page,String search) async {
    final queryParam = {"search": search,"page": page, "per_page": 20};
    List<Product> list = [];
    final dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('/products', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Product.fromJson(e));
        });
      }
      return list;
    } on DioError {
      rethrow;
    }
  }

  Future<List<Category>> getSlugId(String slug) async {
    final queryParam = {"slug": slug};
    final dio = ref.watch(dioProvider);
    List<Category> list = [];
    try {
      final response = await dio.get('/products/categories', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Category.fromJson(e));
        });
      }
      return list;

    } on DioError {
      rethrow;
    }
  }

  Future<List<Product>> getRelatedProducts(String ids) async {
    final queryParam = {"include": ids};
    final dio = ref.watch(dioProvider);
    List<Product> list = [];
    try {
      final response = await dio.get('/products/?', queryParameters: queryParam);
      if (response.statusCode == 200 && response.data != null) {
        response.data.forEach((e) {
          list.add(Product.fromJson(e));
        });
      }
      return list;

    } on DioError {
      rethrow;
    }
  }

}
