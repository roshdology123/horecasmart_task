import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';

class DescriptiveImage extends StatelessWidget {
  const DescriptiveImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/get_your_order.png',width: 300.w,),
        verticalSpace(20),
        Text('Get your order !!',style: TextStyles.font25BlackBold,),
        verticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing, sed do eiusmod tempor ut labore',style: TextStyles.font25BlackBold.copyWith(fontSize: 14,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
        ),
        verticalSpace(30.h),
        MainButton(label: 'Get Started', isEnabled: true, onPressed: (){
          context.pushReplacementNamed(
            Routes.loginScreen
          );
        })
      ],
    );
  }
}
