import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_mini_ecommerce/shared/campaign_card.dart';

class CampaignCarousel extends StatefulWidget {
  const CampaignCarousel({super.key});

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  final List<Map<String, String>> _campaigns = [
    {
      "image": "assets/clothes/women/beige_tights.webp",
      "discount": "15% Off",
    },
    {
      "image": "assets/clothes/women/black_activewear_model_pose.webp",
      "discount": "40% Off",
    },
    {
      "image": "assets/clothes/women/brown_set_ready_pose.webp",
      "discount": "25% Off",
    },
    {
      "image": "assets/clothes/women/hoodie_blackoutfit_fitness_model.webp",
      "discount": "75% Off",
    },
  ];

  int _currentIndex = 0;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Fade-in efekti için gecikmeli görünürlük
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          child: CarouselSlider.builder(
            itemCount: _campaigns.length,
            options: CarouselOptions(
              height: 190,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, _) {
              final campaign = _campaigns[index];
              return CampaignCard(
                imagePath: campaign["image"]!,
                discountText: campaign["discount"]!,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_campaigns.length, (index) {
            final isActive = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white30,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}