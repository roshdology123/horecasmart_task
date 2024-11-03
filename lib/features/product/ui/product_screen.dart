import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';
import 'package:horecasmart_task/features/cart/data/logic/cubit/cart_cubit.dart';
import 'package:horecasmart_task/features/cart/data/models/cart_item_model.dart';
import 'package:horecasmart_task/features/product/data/models/product.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: TextStyles.font14BlackRegular.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: ColorsManager.pureWhite,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.export_3),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.shopping_cart),
            onPressed: () {
              context.pushNamed(Routes.cartScreen);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 325.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.secondarySoftGrey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CachedNetworkImage(
                  alignment: Alignment.center,
                  imageUrl: product.imageUrl,
                  height: 305.h,
                  width: 280.w,
                  fit: BoxFit.fitHeight,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(width: 325.w,height : 300.w,child: Shimmer.fromColors(
                        baseColor: ColorsManager.secondarySoftGrey,
                        highlightColor: ColorsManager.secondaryOffGrey,
                        child: Container(
                          alignment: Alignment.center,
                          height: 325.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorsManager.secondarySoftGrey,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),),
                ),
              ),
              verticalSpace(30),
              Text(product.name, style: TextStyles.font25BlackBold),
              verticalSpace(5),
              Text('${product.price} USD', style: TextStyles.font16WhiteMedium.copyWith(color: const Color(0xFFFE3A30))),
              verticalSpace(10),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ColorsManager.primaryOrangeFreshColor,
                    size: 16.w,
                  ),
                  horizontalSpace(4),
                  Text(
                    product.rating.toString(),
                    style: TextStyles.font12GrayMedium,
                  ),
                  horizontalSpace(4),
                  Text(
                    '(${product.reviews} Reviews)',
                    style: TextStyles.font12GrayRegular,
                  ),
                  const Spacer(),
                  Container(
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.secondaryOffGrey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text('In Stock ${product.stock}', style: TextStyles.font12GrayRegular),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h),
                child: const Divider(color: ColorsManager.secondarySoftGrey,),
              ),

              Text('Description Product', style: TextStyles.font16BlackBold),
              verticalSpace(10),
              Text('${product.description} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', style: TextStyles.font14BlackRegular),
              verticalSpace(20),
              MainButton(label: 'Add to cart', isEnabled: true, onPressed: (){
                _showAddToCartPopup(context,product );
              }),
              verticalSpace(20),

            ],
          ),
        ),
      ),
    );
  }
}
void _showAddToCartPopup(BuildContext context, Product product) {
  int quantity = 1;
  double basePrice = product.price;
  double sizeMultiplier = 1.0;
  String selectedSize = 'Small';
  double totalPrice = basePrice * sizeMultiplier * quantity;
  CartCubit cartCubit = getIt<CartCubit>();


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Add to Cart',
                      style: TextStyles.font16BlackBold,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quantity', style: TextStyles.font16BlackRegular,),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                              totalPrice = basePrice * sizeMultiplier * quantity;
                            });
                          },
                        ),
                        Text('$quantity', style: TextStyles.font16BlackRegular,),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                              totalPrice = basePrice * sizeMultiplier * quantity;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Text('Size', style: TextStyles.font16BlackRegular,),
                  ],
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Small', 'Medium', 'Large'].map((size) {
                    return ChoiceChip(
                      label: Text(size),
                      selected: size == selectedSize,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedSize = size;
                            switch (size) {
                              case 'Small':
                                sizeMultiplier = 1.0;
                                break;
                              case 'Medium':
                                sizeMultiplier = 1.1;
                                break;
                              case 'Large':
                                sizeMultiplier = 1.2;
                                break;
                            }
                            totalPrice = basePrice * sizeMultiplier * quantity;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price', style: TextStyles.font16BlackRegular,),
                    Text('${totalPrice.toStringAsFixed(2)} USD', style: TextStyles.font16BlackBold),
                  ],
                ),
                verticalSpace(20),
                MainButton(
                  onPressed: () {
                    cartCubit.addCartItem(CartItemModel(product: product, quantity: quantity, totalPrice: totalPrice));
                    Navigator.pop(context);
                  },
                  label: 'Add to Cart',
                  isEnabled: true,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
