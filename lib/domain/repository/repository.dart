import '../../core/params/apis.dart';
import '../../data/network_service.dart';
import '../../model/product_model.dart';

abstract class Repository {
  Future<List<ProductModel>> methodGetAllProducts({String api});
}


class RepositoryImplementation implements Repository {
  final Network network;

  const RepositoryImplementation({required this.network});

  @override
  Future<List<ProductModel>> methodGetAllProducts({String api = Api.apiGETProducts}) async {
    try {
      return await network.methodGetAllProducts(api: api);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
