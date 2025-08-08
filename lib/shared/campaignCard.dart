import 'dart:ui'; // For blur effect using BackdropFilter
import 'package:flutter/material.dart';

/// A customizable campaign card widget with a background image, gradient overlay,
/// and a blurred discount label.
class CampaignCard extends StatelessWidget {
  final String imagePath;     // Path to the background image
  final String discountText;  // Text to display as discount info

  const CampaignCard({
    super.key,
    required this.imagePath,
    this.discountText = '30% Off', // Default value if none provided
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity, // Card takes full width
      child: ClipPath(
        // Clip the card shape using a custom path
        clipper: CampaignCardClipper(),
        child: Stack(
          children: [
            // 1. Background image that fills the entire card
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Cover the card area without distortion
              ),
            ),

            // 2. A dark gradient overlay to improve text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.15), // Darker at the bottom
                      Colors.black.withOpacity(0.05), // Lighter at the top
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // 3. Discount text with blurred background
            Positioned(
              bottom: 16,
              left: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Rounded corners
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // Blur effect
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    color: Colors.white.withOpacity(0.1), // Semi-transparent background
                    child: Text(
                      discountText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom clipper that defines the shape of the CampaignCard
class CampaignCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Bottom offsets for asymmetry
    const double bottomLeftYOffset = 12;
    const double bottomRightYOffset = 20;
    const double radius = 20;

    final path = Path();

    // Top-left corner with rounded curve
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    // Top-right corner with rounded curve
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right edge to bottom-right corner with offset and curve
    path.lineTo(size.width, size.height - bottomRightYOffset - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - bottomRightYOffset,
      size.width - radius,
      size.height - bottomRightYOffset,
    );

    // Bottom edge slanted toward the left
    path.lineTo(radius, size.height - bottomLeftYOffset);

    // Bottom-left corner with rounded curve
    path.quadraticBezierTo(
      0,
      size.height - bottomLeftYOffset,
      0,
      size.height - bottomLeftYOffset - radius,
    );

    path.close(); // Complete the path shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false; // No need to reclip
}