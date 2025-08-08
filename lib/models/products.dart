class Product {
  final int id;
  final String category;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite = false;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}