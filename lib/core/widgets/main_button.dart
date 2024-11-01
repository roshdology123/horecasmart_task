import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final VoidCallback onPressed;

  const MainButton({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          325.w,
          50.h
        ),
        backgroundColor: isEnabled ? ColorsManager.primaryBlueOceanColor : ColorsManager.secondaryHalfGrey,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
      child: Text(
        label,
        style: TextStyles.font16WhiteMedium,
      ),
    );
  }
}
