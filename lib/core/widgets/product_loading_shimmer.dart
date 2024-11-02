import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.secondarySoftGrey,
      highlightColor: ColorsManager.secondaryOffGrey,
      enabled: true,
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 130.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.secondarySoftGrey,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            verticalSpace( 16),
            Container(
              height: 16.h,
              width: 120.w,
              color: ColorsManager.secondarySoftGrey,
            ),
            verticalSpace( 8),
            Container(
              height: 16.h,
              width: 80.w,
              color: ColorsManager.secondarySoftGrey,
            ),
            verticalSpace( 8),
            Row(
              children: [
                Container(
                  height: 16.h,
                  width: 16.w,
                  color: ColorsManager.secondarySoftGrey,
                ),
                horizontalSpace(8),
                Container(
                  height: 16.h,
                  width: 60.w,
                  color: ColorsManager.secondarySoftGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}