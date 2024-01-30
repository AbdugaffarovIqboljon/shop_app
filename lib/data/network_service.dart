import 'package:dio/dio.dart';
import 'package:shop_app/model/product_model.dart';

import '../core/params/apis.dart';

class NetworkService {
  final Dio _dio = Dio();

  /// #GET ALL PRODUCTS
  Future<List<ProductModel>> methodGetAllProducts({
    String domain = Api.baseUrl,
  }) async {
    try {
      final response = await _dio.get("$domain${Api.apiGETProducts}");
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  /// #GET Products By ID
  Future<ProductModel> methodGetProductById({
    required int productId,
    String domain = Api.baseUrl,
  }) async {
    try {
      final response =
          await _dio.get("$domain${Api.apiGETProducts}/$productId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = response.data as Map<String, dynamic>;
        final ProductModel product = ProductModel.fromJson(json);
        return product;
      } else {
        throw Exception(
          'Failed to fetch product by ID: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch product by ID: $e');
    }
  }

  /// #GET Products By Category
  Future<List<ProductModel>> methodGetProductsByCategory({
    required String category,
    String domain = Api.baseUrl,
  }) async {
    try {
      final response =
          await _dio.get("$domain${Api.apiGETProducts}/category/$category");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final List<ProductModel> products = jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, Object?>))
            .toList();

        return products;
      } else {
        throw Exception(
            'Failed to fetch products by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }
}
