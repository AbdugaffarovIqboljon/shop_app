import 'package:flutter/material.dart';
import 'package:shop_app/data/network_service.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/model/special_offer.dart';
import 'package:shop_app/screens/special_offers_screen/special_offers_screen.dart';

class SpecialOffersProvider extends ChangeNotifier {
  final NetworkService productService = NetworkService();
  late List<SpecialOffer> _specials;
  late List<ProductModel> _productList;
  late int _selectIndex;

  SpecialOffersProvider() {
    _specials = homeSpecialOffers;
    _productList = [];
    _selectIndex = 0;
    fetchData();
  }

  List<SpecialOffer> get specials => _specials;

  List<ProductModel> get productList => _productList;

  int get selectIndex => _selectIndex;

  Future<void> fetchData() async {
    try {
      List<ProductModel> fetchedProducts =
          await productService.methodGetAllProducts();
      _productList = fetchedProducts;
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  void navigateToSpecialOfferScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SpecialOfferScreen(),
      ),
    );
  }
}
