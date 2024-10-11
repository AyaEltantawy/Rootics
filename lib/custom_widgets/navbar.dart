import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rootics_final/theme/app_colors.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: AppColors().darkGreen),
      ),
      child: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        color: AppColors().lightGreen,
        buttonBackgroundColor: AppColors().lightGreen,
        height: 60,
        index: currentIndex,
        items: [
          Icon(Icons.home, size: 30, color: AppColors().darkGreen2),
          Icon(Icons.camera_alt_rounded, size: 30, color: AppColors().darkGreen2),
          Icon(Icons.favorite, size: 30, color: AppColors().darkGreen2),
          Icon(Icons.person, size: 30, color: AppColors().darkGreen2),
        ],
        onTap: onTap,
      ),
    );
  }
}