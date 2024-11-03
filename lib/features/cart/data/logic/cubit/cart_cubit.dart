import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:horecasmart_task/features/cart/data/models/cart_item_model.dart';

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  final List<CartItemModel> _cartItems = [];
  final FirebaseFirestore _firebaseFirestore;
  CartCubit(this._firebaseFirestore) : super(const CartState.initial());

  void getCartItems() {
    emit(const CartState.loading());
    try {
      debugPrint('Getting cart items ${_cartItems.length}');

      emit(CartState.loaded(_cartItems));
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  void addCartItem(CartItemModel cartItem) {
    debugPrint('Adding cart item: $cartItem');

    // Check if the product already exists in the cart
    final existingItemIndex = _cartItems.indexWhere((item) =>
    item.product.productId == cartItem.product.productId);

    if (existingItemIndex >= 0) {
      final existingItem = _cartItems[existingItemIndex];
      final updatedQuantity = existingItem.quantity + cartItem.quantity;
      final updatedTotalPrice = existingItem.totalPrice + cartItem.totalPrice;

      _cartItems[existingItemIndex] = existingItem.copyWith(
        quantity: updatedQuantity,
        totalPrice: updatedTotalPrice,
      );
    } else {
      _cartItems.add(cartItem);
    }

    emit(CartState.loaded(_cartItems));
  }


  void removeCartItem(CartItemModel cartItem) {
    _cartItems.remove(cartItem);
    emit(CartState.loaded(_cartItems));
  }

  void clearCart() {
    _cartItems.clear();
    emit(CartState.loaded(_cartItems));
  }

  void updateCartItem(CartItemModel cartItem) {
    final index = _cartItems.indexWhere((element) => element.product.productId == cartItem.product.productId);
    _cartItems[index] = cartItem;
    emit(CartState.loaded(_cartItems));
  }

  void deleteCartItem(CartItemModel cartItem) {
    _cartItems.remove(cartItem);
    emit(CartState.loaded(_cartItems));
  }

  void checkout() async {
    await _firebaseFirestore.collection('orders').add({
      'items': _cartItems.map((e) => e.toJson()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    _cartItems.clear();
    emit(CartState.loaded(_cartItems));

  }
}
