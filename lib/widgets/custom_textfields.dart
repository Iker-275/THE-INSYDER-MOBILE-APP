import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final String? Function(String?)? validator;
  final IconData? icon;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkAccent.withOpacity(0.3) : Colors.black26;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontSize: 15.sp,
          color: textColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null
              ? Icon(icon, color: textColor.withOpacity(0.7), size: 22.sp)
              : null,
          filled: true,
          fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1.4),
          ),
          labelStyle: TextStyle(color: textColor.withOpacity(0.8)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withOpacity(0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
            suffixIcon: suffixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: theme.colorScheme.primary, width: 1.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool enabled;
  final bool obscure;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.enabled = true,
    this.obscure = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: obscure,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 14.sp,
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint ?? label,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled
                ? theme.colorScheme.surface
                : theme.colorScheme.surface.withOpacity(0.6),
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 14.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ),
      ),
      style: TextStyle(
        fontSize: 14.sp,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
