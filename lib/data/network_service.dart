import 'package:dio/dio.dart';
import 'package:shop_app/model/product_model.dart';

import '../core/params/apis.dart';

abstract class Network {
  Future<List<ProductModel>> methodGetAllProducts({
    String domain = Api.baseUrl,
    required String api,
  });
}

class DioService implements Network {
  late final Dio _dio;

  DioService() {
    _dio = Dio();
  }

  @override
  Future<List<ProductModel>> methodGetAllProducts({
    String domain = Api.baseUrl,
    required String api,
  }) async {
    try {
      final response = await _dio.get("$domain$api");
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final List<ProductModel> products = jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, Object?>))
            .toList();

        return products;
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}

