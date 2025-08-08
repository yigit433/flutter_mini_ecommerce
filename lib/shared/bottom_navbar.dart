import 'package:flutter/material.dart';

class FancyBottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const FancyBottomNavBar({super.key, this.selectedIndex = 0});

  @override
  State<FancyBottomNavBar> createState() => _FancyBottomNavBarState();
}

class _FancyBottomNavBarState extends State<FancyBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  final icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.person,
    Icons.receipt_long,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / icons.length;

    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF1B1F2A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Render all unselected icons in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isSelected = index == _selectedIndex;
              if (isSelected) {
                return const SizedBox(
                  width: 60,
                ); // Reserve space for the selected icon
              }

              return IconButton(
                onPressed: () => setState(() => _selectedIndex = index),
                icon: Icon(icons[index], color: Colors.grey.shade500, size: 26),
              );
            }),
          ),

          // Render the selected icon inside a floating custom-shaped container
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            top: -20,
            left: itemWidth * _selectedIndex + (itemWidth - 60) / 2,
            child: GestureDetector(
              onTap: () {},
              child: ClipPath(
                clipper: SlantedRoundedClipper(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4FC3F7), Color(0xFF2979FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icons[_selectedIndex],
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper that draws a slanted, rounded container shape
class SlantedRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double radius = 12;

    final path = Path();

    // Top-left corner is slightly lower than top-right for a slanted effect
    path.moveTo(radius, 6);

    // Top-right corner
    path.lineTo(size.width - radius - 6, 0);
    path.quadraticBezierTo(size.width, 0, size.width - 4, radius);

    // Bottom-right corner
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width - 2,
      size.height,
      size.width - radius - 4,
      size.height,
    );

    // Bottom-left corner is slightly lower than bottom-right
    path.lineTo(radius, size.height + 4);
    path.quadraticBezierTo(0, size.height + 4, 0, size.height - radius + 4);

    // Left side
    path.lineTo(0, radius + 6);
    path.quadraticBezierTo(0, 6, radius, 6);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}