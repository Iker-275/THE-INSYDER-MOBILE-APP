// lib/features/home/widgets/article_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/models/article.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/models/article.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  width: 90.w,
                  height: 90.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 90.w,
                    height: 90.w,
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_outlined, size: 30),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 90.w,
                    height: 90.w,
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined, size: 28),
                  ),
                ),
              ),
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      article.author,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    if (article.genre != null && article.genre!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          article.genre!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ArticleCard extends StatelessWidget {
//   final ArticleModel article;
//
//   const ArticleCard({super.key, required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // TODO: navigate to article details
//       },
//       child: Container(
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12.r),
//               child: Image.network(
//                 article.imageUrl!,
//                 width: 90.w,
//                 height: 90.w,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     article.title,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     article.author,
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontSize: 13.sp,
//                     ),
//                   ),
//                   SizedBox(height: 6.h),
//                   Text(
//                     article.genre!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onSurface
//                           .withOpacity(0.7),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
