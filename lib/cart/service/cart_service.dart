import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_wp_woocommerce/models/cart_item.dart';
import 'package:flutter_wp_woocommerce/models/product_variation.dart';
import 'package:flutter_wp_woocommerce/woocommerce_error.dart';
import 'package:http/http.dart' as http;

import '../model/cart_item.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio);

  // Future<Either<Failure, RegisterResponse>> register(
  //     {required String userName,
  //     required String email,
  //     required String password}) async {
  //   final formData = {
  //     "username": userName,
  //     "email": email,
  //     "password": password
  //   };
  //   try {
  //     final result =
  //         await _dio.post('/wp-json/wc/v3/customers', data: formData);
  //     return right(RegisterResponse.fromJson(result.data));
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failure);
  //   }
  // }
  //
  // Future<Either<Failure, LoginResponse>> login(
  //     {required String userName, required String password}) async {
  //   final formData = {"username": userName, "password": password};
  //   try {
  //     final result =
  //         await _dio.post('/wp-json/jwt-auth/v1/token', data: formData);
  //     return right(LoginResponse.fromJson(result.data));
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failure);
  //   }
  // }
  //
  // Future<Either<Failure, bool>> validateLogin(String token) async {
  //   try {
  //     final result = await _dio.post('/wp-json/jwt-auth/v1/token/validate',
  //         options: Options(headers: authHeader(token)));
  //     bool isSuccess = result.statusCode == 200 ? true : false;
  //     return right(isSuccess);
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failure);
  //   }
  // }
  // Future<Either<Failure, String>> getNonce(String token) async {
  //   Map<String, String> urlHeader = {'Authorization': ''};
  //   urlHeader['Authorization'] = 'Bearer ${token!}';
  //   try {
  //     final result = await _dio.get('/wp-json/wc/store/cart/items',
  //         options: Options(headers: urlHeader));
  //     // debugPrint("header ** ${result.headers}");
  //     final header = result.headers;
  //     final nonce = header.value("nonce");
  //     return right(nonce!);
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failure);
  //   }
  // }

  // Future<Either<Failure, List<WooCartItem>>> getCart(String token) async {
  //   try {
  //     List<WooCartItem> list = [];
  //     final result = await _dio.get('/wp-json/wc/store/cart/items',
  //         options: Options(headers: {'Authorization': 'Bearer $token'}));
  //     debugPrint("get cart ${result.data}");
  //     result.data.forEach((e) {
  //       list.add(WooCartItem.fromJson(e));
  //     });
  //
  //     return right(list);
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failure);
  //   }
  // }

  // Future<Either<Failure, bool>> addToMyCart({
//   required String token,
//   required String nonce,
//   required int itemId,
//   required int quantity,
// }) async {
//   debugPrint("add to cart id $itemId");
//   debugPrint("add to cart nonce $nonce");
//   Map<String, dynamic> data = {
//     'id': itemId,
//     'quantity': quantity,
//   };
//   try {
//     final result = await _dio.post('/wp-json/wc/store/cart/add-item',
//         data: data,
//         options: Options(headers: {
//           "Authorization": "Bearer $token",
//           "X-WC-Store-API-Nonce": "$nonce",
//         }));
//     debugPrint("add to cart response ${result.data}");
//     final isSuccess = result.statusCode == 200 ? true : false;
//
//     return right(isSuccess);
//   } on DioError catch (e) {
//     return left(DioException.fromDioError(e).failure);
//   }
// }

  Future<String> getNonce(String token) async {
    Map<String, String> urlHeader = {'Authorization': ''};
    urlHeader['Authorization'] = 'Bearer ${token!}';
    final response = await http.get(
        Uri.parse(
            'https://demo.ktechnologygroup.com/wp-json/wc/store/cart/items'),
        headers: urlHeader);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final header = response.headers;
      var entryList = header.entries.toList();

      return entryList[0].value;
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }

  Future<List<CartItem>> getMyCartItem(String token) async {
    Map<String, String> urlHeader = {'Authorization': ''};
    urlHeader['Authorization'] = 'Bearer ${token!}';
    final response = await http.get(
        Uri.parse(
            'https://demo.ktechnologygroup.com/wp-json/wc/store/cart/items'),
        headers: urlHeader);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonStr = json.decode(response.body);
      List<CartItem> cartItems = [];
      for (var p in jsonStr) {
        var prod = CartItem.fromJson(p);
        cartItems.add(prod);
      }
      return cartItems;
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }

  Future<WooCartItem> addToMyCart(
      {required String itemId,
      required String quantity,
      required String token,
      required String nonce,
      List<WooProductVariation>? variations}) async {
    Map<String, dynamic> data = {
      'id': itemId,
      'quantity': quantity,
    };
    Map<String, String> urlHeader = {
      'Authorization': '',
      "X-WC-Store-API-Nonce": ''
    };
    urlHeader['Authorization'] = 'Bearer ${token!}';
    urlHeader['X-WC-Store-API-Nonce'] = nonce!;
    if (variations != null) data['variations'] = variations;
    final response = await http.post(
        Uri.parse(
            'https://demo.ktechnologygroup.com/wp-json/wc/store/cart/items'),
        headers: urlHeader,
        body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonStr = json.decode(response.body);
      return WooCartItem.fromJson(jsonStr);
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }

  Future delete({
    required String key,
    required String token,
    required String nonce,
  }) async {
    Map<String, dynamic> data = {
      'key': key,
    };
    Map<String, String> urlHeader = {
      'Authorization': '',
      "X-WC-Store-API-Nonce": ''
    };
    urlHeader['Authorization'] = 'Bearer ${token!}';
    urlHeader['X-WC-Store-API-Nonce'] = nonce!;
    final http.Response response = await http.delete(
        Uri.parse(
            'https://demo.ktechnologygroup.com/wp-json/wc/store/cart/items'),
        headers: urlHeader,
        body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }
}
