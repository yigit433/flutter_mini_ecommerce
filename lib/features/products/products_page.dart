import 'package:flutter/material.dart';
import 'package:flutter_mini_ecommerce/core/repository/products/product_repository_impl.dart';
import 'package:flutter_mini_ecommerce/models/products.dart';
import 'package:flutter_mini_ecommerce/shared/campaign_card.dart';
import 'package:flutter_mini_ecommerce/shared/campaign_carousel.dart';
import 'package:flutter_mini_ecommerce/shared/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepositoryImpl _productRepository = ProductRepositoryImpl();

  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productRepository.getAllProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Ürünler çekilirken hata: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF121829),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Choose Your Style',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                // tıklama olayı
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 27.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CampaignCarousel(),
            const SizedBox(height: 16),
            _buildFilterRow(),
            const SizedBox(height: 16),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    final filters = [
      'All',
      'Activewear',
      'Tops',
      'Bottoms',
      'Shoes',
      'Accessories',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((e) {
          final isSelected = e == 'All';
          return Container(
            margin: const EdgeInsets.only(right: 10), // spacing araları
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isSelected ? null : Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: Text(
            'Ürün bulunamadı.',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = _products[index];
        return StylishProductCard(
          imagePath: product.imageUrl,
          category: product.category,
          title: product.name,
          price: product.price,
          isFavorite: false, // favori kontrolün varsa güncelle
        );
      },
    );
  }
}
