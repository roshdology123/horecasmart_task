import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MainInputField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final bool isSearch; // New parameter for search icon
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? explanation;

  const MainInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isSearch = false, // Default to false if not specified
    this.validator,
    this.explanation,
  });

  @override
  State<MainInputField> createState() => _MainInputFieldState();
}

class _MainInputFieldState extends State<MainInputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyles.font14BlackRegular,
        ),
        verticalSpace(20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyles.font14LightGrayRegular,
            filled: true,
            fillColor: ColorsManager.secondaryOffGrey,
            contentPadding: EdgeInsets.only(left: 16, top: 16.w, bottom: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorsManager.secondaryDarkGrey,
              ),
              onPressed: _togglePasswordVisibility,
            )
                : widget.isSearch
                ? const Icon(
              Iconsax.search_normal,
              color: ColorsManager.secondaryDarkGrey,
            )
                : null,
          ),
        ),
        verticalSpace(10.h),
        if (widget.explanation != null)
          Text(
            widget.explanation!,
            style: TextStyles.font14LightGrayRegular,
          ),
      ],
    );
  }
}
