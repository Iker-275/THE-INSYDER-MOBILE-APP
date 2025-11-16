import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ArticleSkeletonList extends StatelessWidget {
  const ArticleSkeletonList({super.key, this.itemCount = 5});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
          highlightColor: theme.colorScheme.surfaceVariant.withOpacity(0.1),
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.h,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 14.h,
                        width: 120.w,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 12.h,
                        width: 80.w,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(radius: 45.r),
          ),
          SizedBox(height: 20.h),
          _shimmerBox(height: 50.h),
          SizedBox(height: 12.h),
          _shimmerBox(height: 50.h),
          SizedBox(height: 12.h),
          _shimmerBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
