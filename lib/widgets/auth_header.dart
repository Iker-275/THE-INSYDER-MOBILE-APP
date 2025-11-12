import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        Icon(Icons.menu_book_rounded,
            size: 64.sp, color: Theme.of(context).colorScheme.primary),
        SizedBox(height: 12.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: textColor.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
