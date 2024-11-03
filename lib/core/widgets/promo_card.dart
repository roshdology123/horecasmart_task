import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';

class PromotionCard extends StatelessWidget {
  final String imageUrl;
  final String productName;

  const PromotionCard({super.key,
    required this.imageUrl,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.promoCardGradientStart,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style: TextStyles.font25BlackBold.copyWith(
                  color: ColorsManager.pureWhite,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    "Shop now",
                    style: TextStyles.font14BlackRegular.copyWith(
                      color: ColorsManager.pureWhite.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward,
                    color: ColorsManager.pureWhite.withOpacity(0.8),
                    size: 16.w,
                  ),
                ],
              ),
            ],
          ),
          // Image Section
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 125.h,
            width: 125.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
