import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/core/widgets/main_input_field.dart';
import 'package:horecasmart_task/core/widgets/product_card.dart';
import 'package:horecasmart_task/core/widgets/product_loading_shimmer.dart';
import 'package:horecasmart_task/core/widgets/promo_card.dart';
import 'package:horecasmart_task/features/home/data/logic/cubit/home_cubit.dart';
import 'package:horecasmart_task/features/home/ui/widgets/category_tab_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/logic/cubit/auth_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late TextEditingController searchController;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecom Mall', style: TextStyles.font18DarkBlueSemiBold),
        backgroundColor: ColorsManager.pureWhite,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              context.read<AuthCubit>().signOut();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: MainInputField(
                  label: '',
                  hint: 'Search Product Name',
                  controller: searchController,
                  isSearch: true),
            ),
            verticalSpace(30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset('assets/images/get_your_discount.png',
                      width: 350.w, height: 177.h, fit: BoxFit.cover),
                  Image.asset('assets/images/get_your_discount.png',
                      width: 350.w, height: 177.h, fit: BoxFit.cover),
                ],
              ),
            ),
            CategoryTabView(categories: [
              CategoryItem(
                  icon: Iconsax.cake,
                  label: 'Foods',
                  backgroundColor: const Color(0xffE4F3EA),
                  iconColor: ColorsManager.primaryNavyBlackColor),
              CategoryItem(
                  icon: Iconsax.bezier,
                  label: 'Drinks',
                  backgroundColor: const Color(0xffFFECE8),
                  iconColor: ColorsManager.primaryOrangeFreshColor),
              CategoryItem(
                  icon: Iconsax.cake,
                  label: 'Foods',
                  backgroundColor: const Color(0xffE4F3EA),
                  iconColor: ColorsManager.primaryNavyBlackColor),
              CategoryItem(
                  icon: Iconsax.bezier,
                  label: 'Drinks',
                  backgroundColor: const Color(0xffFFECE8),
                  iconColor: ColorsManager.primaryOrangeFreshColor),
              CategoryItem(
                  icon: Iconsax.cake,
                  label: 'Foods',
                  backgroundColor: const Color(0xffE4F3EA),
                  iconColor: ColorsManager.primaryNavyBlackColor),
              CategoryItem(
                  icon: Iconsax.bezier,
                  label: 'Drinks',
                  backgroundColor: const Color(0xffFFECE8),
                  iconColor: ColorsManager.primaryOrangeFreshColor),
            ],
            onCategorySelected: (category) {
              context.read<HomeCubit>().selectCategory(category.label);
            }
            ),
            verticalSpace(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Featured Product', style: TextStyles.font18DarkBlueBold),
                  GestureDetector(
                    // onTap: () => _showAllCategoriesDialog(context),
                    child: Text('See All', style: TextStyles.font13BlueRegular),
                  ),
                ],
              ),
            ),
            verticalSpace(30),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const ProductCardShimmer(),
                  loading: () => const ProductCardShimmer(),
                  error: (message) => Center(
                    child: Text(message),
                  ),
                  loaded:(products) => SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      itemCount: products.length,

                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: ProductCard(
                            onTap: () {
                              context.pushNamed(
                                Routes.productDetail,
                                arguments: product,
                              );
                            },
                            imageUrl: product.imageUrl,
                            productName: product.name,
                            price: product.price.toString(),
                            rating: product.rating,
                            reviews: product.reviews,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            verticalSpace(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: const PromotionCard(
                  imageUrl: 'https://img.freepik.com/free-psd/cosmetic-bottle-container-isolated_23-2151352942.jpg?t=st=1730569189~exp=1730572789~hmac=9889b2ac78bdb970da5ca21d2c7e7d279e85091182193949de13fe278101d8d9&w=740',
                  productName: 'Mocha Cream'),
            ),

            verticalSpace(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Top Rated Products', style: TextStyles.font18DarkBlueBold),
                  GestureDetector(
                    // onTap: () => _showAllCategoriesDialog(context),
                    child: Text('See All', style: TextStyles.font13BlueRegular),
                  ),
                ],
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const ProductCardShimmer(),
                  loading: () => const ProductCardShimmer(),
                  error: (message) => Center(
                    child: Text(message),
                  ),
                  loaded:(products)
                  {
                    final products = context.read<HomeCubit>().getTopRatedProducts(3);
                    return SizedBox(
                      height: 250.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: ProductCard(
                              onTap: () {
                               context.pushNamed(
                                  Routes.productDetail,
                                  arguments: product,

                                );
                              },
                              imageUrl: product.imageUrl,
                              productName: product.name,
                              price: product.price.toString(),
                              rating: product.rating,
                              reviews: product.reviews,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            verticalSpace(30),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> products = [
  {
    'imageUrl': 'https://img.freepik.com/free-psd/cosmetic-bottle-container-isolated_23-2151352942.jpg',
    'productName': 'Mocha Cream',
    'price': '\$100',
    'rating': 4.5,
    'reviews': 100,
  },
  {
    'imageUrl': 'https://img.freepik.com/free-psd/cosmetic-bottle-container-isolated_23-2151352942.jpg',
    'productName': 'Mocha Cream',
    'price': '\$100',
    'rating': 4.5,
    'reviews': 100,
  },
  {
    'imageUrl': 'https://img.freepik.com/free-psd/cosmetic-bottle-container-isolated_23-2151352942.jpg',
    'productName': 'Mocha Cream',
    'price': '\$100',
    'rating': 4.5,
    'reviews': 100,
  },
];