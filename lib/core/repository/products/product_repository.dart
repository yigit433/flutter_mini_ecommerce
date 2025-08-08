import 'package:flutter_mini_ecommerce/models/products.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
}