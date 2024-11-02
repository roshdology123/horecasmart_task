import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTabView extends StatelessWidget {
  final List<CategoryItem> categories;

  const CategoryTabView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories', style: TextStyles.font18DarkBlueBold),
              GestureDetector(
                onTap: () => _showAllCategoriesDialog(context),
                child: Text('See All', style: TextStyles.font13BlueRegular),
              ),
            ],
          ),
        ),
        verticalSpace( 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            children: categories.map((item) {
              return Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: CategoryIconTile(
                  icon: item.icon,
                  label: item.label,
                  backgroundColor: item.backgroundColor,
                  iconColor: item.iconColor,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showAllCategoriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('All Categories', style: TextStyles.font18DarkBlueBold),
                    IconButton(
                      icon: const Icon(Icons.close, color: ColorsManager.primaryNavyBlackColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                verticalSpace( 12.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return CategoryIconTile(
                      icon: item.icon,
                      label: item.label,
                      backgroundColor: item.backgroundColor,
                      iconColor: item.iconColor,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryIconTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryIconTile({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0.h,
          width: 50.0.w,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Icon(icon, color: iconColor, size: 28.sp),
          ),
        ),
        verticalSpace(8),
        Text(label, style: TextStyles.font14BlackRegular),
      ],
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  CategoryItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });
}
