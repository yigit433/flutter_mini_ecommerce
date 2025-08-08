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
        description:
            "Hareket özgürlüğü ve şıklığı bir araya getiren dikişsiz tayt. Spor ve günlük stilin vazgeçilmezi.",
        price: 21.99,
        imageUrl: "assets/clothes/women/beige_tights.webp",
      ),

      Product(
        id: 2,
        category: 'Activewear',
        name: "EarthTone Power Set",
        description:
            "Toprak tonlarında tasarlanan bu takım, doğallığı ve gücü stilinle buluşturur. Hem stüdyoda hem sokakta fark yarat.",
        price: 24.99,
        imageUrl: "assets/clothes/women/brown_set_ready_pose.webp",
      ),

      Product(
        id: 3,
        category: 'Activewear',
        name: "UrbanFit Hoodie Set",
        description:
            "Leopar dokulu siyah taytı ve sade hoodie kombiniyle şehir hayatına uyumlu rahatlık ve stil bir arada.",
        price: 27.49,
        imageUrl: "assets/clothes/women/hoodie_blackoutfit_fitness_model.webp",
      ),

      Product(
        id: 4,
        category: 'Activewear',
        name: "ChillFlex Jogger Combo",
        description:
            "Outdoor kombinlerin vazgeçilmezi: Yumuşak dokulu jogger ve basic tişört rahatlığıyla spor sonrası da stilinden ödün verme.",
        price: 23.99,
        imageUrl: "assets/clothes/women/outdoor_casual_style_model.webp",
      ),

      Product(
        id: 5,
        category: 'Activewear',
        name: "StudioCore Black Set",
        description:
            "Klasik siyahın zamansız gücü, ergonomik formda buluştu. Hem pozitif hem performans odaklı kadınlar için.",
        price: 25.99,
        imageUrl: "assets/clothes/women/sleek_black_leggings_bra_set.webp",
      ),

      Product(
        id: 6,
        category: 'Activewear',
        name: "SculptFlex Training Tights",
        description:
            "Güçlü duruşun simgesi bu tayt, spor yaparken sana maksimum esneklik ve destek sunar. Motivasyon pozunda bile şık.",
        price: 22.99,
        imageUrl: "assets/clothes/women/black_activewear_model_pose.webp",
      ),
    ];
  }
}
