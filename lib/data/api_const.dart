import 'package:dio/dio.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

class ApiHelper {
  ApiHelper._();

  static const String mainUrl = "https://demo.ktechnologygroup.com";

  static const String key = 'ck_04e20dfdb8a6eb318560be97c97c2abfa244167c';
  static const String secret = 'cs_16b2d1b21cd1dddcad6a9df9da39689d4f6b1bd1';

  // static const createCustomer = "$mainUrl$path/customers$auth";

  static WooCommerce wooCommerce = WooCommerce(
    baseUrl: mainUrl,
    consumerKey: key,
    consumerSecret: secret,
    isDebug: true,
  );
}
