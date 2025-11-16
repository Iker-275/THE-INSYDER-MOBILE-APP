import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = false,
    this.onBack,
    this.leading,
    required bool centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textColor = isDark ? AppColors.lightPrimary : AppColors.darkPrimary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (showBack)
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  height: 38.h,
                  width: 38.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.lightPrimary.withOpacity(0.08)
                        : AppColors.darkPrimary.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18.sp,
                    color: textColor,
                  ),
                ),
              )
            else if (leading != null)
              leading!,
            if (showBack || leading != null) SizedBox(width: 12.w),

            // Title
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),

            // Actions
            if (actions != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(72.h);
}
