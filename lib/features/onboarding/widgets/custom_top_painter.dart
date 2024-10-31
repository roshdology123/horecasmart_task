import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';

class CustomTopPainter extends StatelessWidget {
  const CustomTopPainter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: [
        CustomPaint(
          size: Size(375.w, 340.h),
          painter: TopCurvePainter(),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                verticalSpace(50),
                Image.asset('assets/icons/app_icon.png',width: 50.w,),
                Text('eCommerce Shop',style: TextStyles.font18WhiteMedium.copyWith(fontSize: 28.sp,),),
                Divider(
                  color: Colors.white,
                  indent: 110.w,
                ),
                SizedBox(
                  width: 200.w,
                  child: Text('Professional App for your eCommerce business',style: TextStyles.font16WhiteMedium.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ColorsManager.primaryBlueOceanColor;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 1,
      size.width, size.height * 0.9,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}