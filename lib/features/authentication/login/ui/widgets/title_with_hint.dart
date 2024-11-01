import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWithHint extends StatelessWidget {
  const TitleWithHint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220.w,
          child: Text(
            'Welcome back to eCom Mall',
            style: TextStyles.font25BlackBold,
          ),
        ),
        verticalSpace(20.h),
        Text(
          'Login to get the full features of the app',
          style: TextStyles.font14GrayRegular,
        ),
      ],
    );
  }
}
