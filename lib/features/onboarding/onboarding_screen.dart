import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/features/onboarding/widgets/custom_top_painter.dart';
import 'package:horecasmart_task/features/onboarding/widgets/discriptive_image.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTopPainter(),
            DescriptiveImage(),
          ],
        ),
      ))
    );
  }
}

