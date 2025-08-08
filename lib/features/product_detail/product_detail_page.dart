import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_ecommerce/shared/loading/loading_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_mini_ecommerce/models/products.dart';
import 'package:flutter_mini_ecommerce/core/repository/products/product_repository_impl.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductRepositoryImpl _productRepository = ProductRepositoryImpl();

  Product? product;
  String? selectedSize;

  bool _isLoading = true;

  final List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void fetchProduct() async {
    final fetched = await _productRepository.getProductById(
      int.parse(widget.productId),
    );
    if (fetched == null) return;

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      product = fetched;
      _isLoading = false;
      imageUrls.addAll([
        product!.imageUrl,
        product!.imageUrl,
        product!.imageUrl,
        product!.imageUrl,
      ]);
    });
  }

  void _openFullScreenGallery(int initialIndex) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: imageUrls.length,
                options: CarouselOptions(
                  initialPage: initialIndex,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                ),
                itemBuilder: (context, index, _) {
                  return PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    imageProvider: AssetImage(imageUrls[index]),
                  );
                },
              ),
              Positioned(
                top: 32,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading || product == null
          ? LoadingScreen(
              message: 'Loading product details...',
            )
          : Stack(
              children: [
                _buildProductImageCarousel(),
                _buildTopBar(),
                _buildFixedProductInfo(),
              ],
            ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                product!.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImageCarousel() {
    int _currentIndex = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            CarouselSlider.builder(
              itemCount: imageUrls.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) =>
                    setState(() => _currentIndex = index),
              ),
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () => _openFullScreenGallery(index),
                  child: Image.asset(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              },
            ),
            Positioned(
              bottom:
                  MediaQuery.of(context).size.height *
                  0.48, // sabit 100 yerine orantılı
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imageUrls.length, (index) {
                  final isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFixedProductInfo() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: ['S', 'M', 'L', 'XL'].map((size) {
                      final bool isSelected = selectedSize == size;
                      return ChoiceChip(
                        label: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        selectedColor: const Color(0xFF4A90E2), // Seçili rengin
                        backgroundColor: Colors.grey[800],
                        elevation: isSelected ? 4 : 0,
                        side: BorderSide(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        labelStyle: const TextStyle(fontSize: 16),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product!.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF90CAF9),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2979FF),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Reviews",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: List.generate(3, (index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          "User ${index + 1}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Great product!",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
