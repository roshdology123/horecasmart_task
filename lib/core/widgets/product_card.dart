import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final double rating;
  final int reviews;

  const ProductCard({super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorsManager.pureWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 130.h,
              fit: BoxFit.contain,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(width: 40.w,height : 40.w,child: CircularProgressIndicator(value: downloadProgress.progress)),
            ),
          ),
          verticalSpace(16),
          // Product Name
          Text(
            productName,
            style: TextStyles.font14DarkBlueBold,
          ),
          verticalSpace(4),
          // Price
          Text(
            price,
            style: TextStyles.font14BlueSemiBold.copyWith(
              color: ColorsManager.primaryOrangeFreshColor,
            ),
          ),
          verticalSpace(4),
          // Rating and Reviews
          Row(
            children: [
              Icon(
                Icons.star,
                color: ColorsManager.primaryOrangeFreshColor,
                size: 16.w,
              ),
              horizontalSpace(4),
              Text(
                rating.toString(),
                style: TextStyles.font12GrayMedium,
              ),
              horizontalSpace(4),
              Text(
                '($reviews Reviews)',
                style: TextStyles.font12GrayRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
