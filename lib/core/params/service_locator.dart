import 'package:shop_app/data/network_service.dart';

import '../../domain/repository/repository.dart';
import '../../services/cart_service/add_to_cart_service.dart';

late final Repository repository;

Future<void> serviceLocator() async {
  repository = RepositoryImplementation(network: DioService());
}



