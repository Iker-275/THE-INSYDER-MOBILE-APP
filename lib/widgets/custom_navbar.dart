import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🎨 Dynamic theme colors
    final backgroundColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface; // smooth container
    final activeColor =
        isDark ? AppColors.primary : AppColors.primary; // accent
    final inactiveColor =
        isDark ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.55);

    return Container(
      height: 72.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.35)
                : Colors.grey.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isSelected = index == currentIndex;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(14.r),
              splashColor: activeColor.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: isSelected ? 4.h : 2.h,
                      width: 28.w,
                      margin: EdgeInsets.only(bottom: 4.h),
                      decoration: BoxDecoration(
                        color: isSelected ? activeColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                    ),
                    Icon(
                      item.icon,
                      size: isSelected ? 24.sp : 22.sp,
                      color: isSelected ? activeColor : inactiveColor,
                    ),
                    SizedBox(height: 3.h),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: isSelected ? 13.sp : 12.sp,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? activeColor : inactiveColor,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

// 🔖 Based on your UI — clean, magazine-like tabs
final List<_NavItem> _items = [
  _NavItem(Icons.home_rounded, 'Home'),
  _NavItem(Icons.search_rounded, 'Explore'),
  _NavItem(Icons.edit_note_rounded, 'Write'),
  _NavItem(Icons.person_outline_rounded, 'Profile'),
];
