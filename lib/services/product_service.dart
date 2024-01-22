import 'dart:async';

import 'package:path/path.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static const String dbName = 'products.db';

  late Database _database;

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    _database = await openDatabase(path, version: 1, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            rate REAL,
            count INTEGER
          )
        ''');
    });
  }

  Future<void> insertProduct(ProductModel product) async {
    await _database.insert(
      'products',
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rate': product.rating.rate,
        'count': product.rating.count,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeProduct(int productId) async {
    await _database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final List<Map<String, dynamic>> maps = await _database.query('products');

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        rating: Rating(rate: maps[i]['rate'], count: maps[i]['count']),
      );
    });
  }

  Future<bool> containsProduct(int productId) async {
    final result = await _database.rawQuery(
      'SELECT COUNT(*) FROM products WHERE id = ?',
      [productId],
    );
    final count = Sqflite.firstIntValue(result);
    return count != null && count > 0;
  }

  Future<int> updateProductQuantity({
    required int productId,
    required int quantity,
  }) async {
    final result = await _database.rawUpdate(
      'UPDATE products SET count = count + ? WHERE id = ?',
      [quantity, productId],
    );
    return result;
  }
}


class ProductService {
  final ProductDatabase _productDatabase = ProductDatabase();

  Future<void> saveProductToCart(ProductModel product) async {
    await _productDatabase.open();
    await _productDatabase.insertProduct(product);
  }

  Future<List<ProductModel>> getSavedProducts() async {
    await _productDatabase.open();
    return _productDatabase.getProducts();
  }

  Future<void> removeProductFromCart(int productId) async {
    await _productDatabase.open();
    await _productDatabase.removeProduct(productId);
  }
}
