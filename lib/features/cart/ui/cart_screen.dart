import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';
import 'package:horecasmart_task/features/cart/data/logic/cubit/cart_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}
bool isEmptyCart = true;
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Ensure cart items are loaded when the screen is shown
    context.read<CartCubit>().getCartItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {

          return state.when(

            initial: () => const Center(child: Text('Cart is empty')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (cartItems) => cartItems.isEmpty
                ? const Center(child: Text('Cart is empty'))
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                isEmptyCart = cartItems.isEmpty;
                final cartItem = cartItems[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    alignment: Alignment.center,
                    imageUrl: cartItem.product.imageUrl,
                    height: 130.h,
                    width: 130.w,
                    fit: BoxFit.fitHeight,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Shimmer.fromColors(
                            baseColor: ColorsManager.secondarySoftGrey,
                            highlightColor: ColorsManager.secondaryOffGrey,
                            child: Container(
                              alignment: Alignment.center,
                              height: 130.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorsManager.secondarySoftGrey,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                  ),
                  title: Text(cartItem.product.name),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        context.read<CartCubit>().removeCartItem(cartItem);
                        context.read<CartCubit>().getCartItems();
                      });
                    },
                  ),
                );
              },
            ),
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MainButton(
          onPressed: () {
            context.read<CartCubit>().checkout();
          },
          label: 'Checkout',
          isEnabled: isEmptyCart ? false : true,
        ),
      ),
    );
  }
}