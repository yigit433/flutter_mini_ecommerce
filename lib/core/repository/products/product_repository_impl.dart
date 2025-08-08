import 'package:flutter_mini_ecommerce/models/products.dart';

import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(Duration(milliseconds: 500));

    return [
      Product(
        id: 1,
        category: 'Activewear',
        name: "FlexFit Seamless Tights",
        description: "Hareket özgürlüğü ve şıklığı bir araya getiren dikişsiz tayt. Spor ve günlük stilin vazgeçilmezi.",
        price: 21.99,
        imageUrl: "assets/clothes/women/beige_tights.webp",
      ),
      Product(
        id: 2,
        category: 'Activewear',
        name: "FlexFit Seamless Tights",
        description: "Hareket özgürlüğü ve şıklığı bir araya getiren dikişsiz tayt. Spor ve günlük stilin vazgeçilmezi.",
        price: 21.99,
        imageUrl: "assets/clothes/women/beige_tights.webp",
      ),
      Product(
        id: 3,
        category: 'Activewear',
        name: "FlexFit Seamless Tights",
        description: "Hareket özgürlüğü ve şıklığı bir araya getiren dikişsiz tayt. Spor ve günlük stilin vazgeçilmezi.",
        price: 21.99,
        imageUrl: "assets/clothes/women/beige_tights.webp",
      ),
      Product(
        id: 4,
        category: 'Activewear',
        name: "FlexFit Seamless Tights",
        description: "Hareket özgürlüğü ve şıklığı bir araya getiren dikişsiz tayt. Spor ve günlük stilin vazgeçilmezi.",
        price: 21.99,
        imageUrl: "assets/clothes/women/beige_tights.webp",
      ),
    ];
  }
}
