
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../environmental_config.dart';

final dioProvider = Provider < Dio > ((ref) {
  final queryParam = {
    "consumer_key": "ck_04e20dfdb8a6eb318560be97c97c2abfa244167c",
    "consumer_secret": "cs_16b2d1b21cd1dddcad6a9df9da39689d4f6b1bd1",
  };
  return Dio(BaseOptions(
    baseUrl: EnvironmentConfig.baseUrl,
    queryParameters: queryParam,
      // connectTimeout: 60 *1000,
      // receiveTimeout: 60 * 100
  ));
});