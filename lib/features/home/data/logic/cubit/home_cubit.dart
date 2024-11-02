import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/features/home/data/models/product.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final _products = <Product>[];
  final FirebaseFirestore _firebaseFirestore = getIt<FirebaseFirestore>();
  HomeCubit() : super(const HomeState.initial());

  Future<void> getProducts() async {
    try {
      emit(const HomeState.loading());
      final products = await _firebaseFirestore.collection('products').get();
      _products.clear();
      for (final product in products.docs) {
        _products.add(Product.fromJson(product.data()));
      }
      emit(HomeState.loaded(_products));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }
  void addProduct(Product product) {
    _products.add(product);
    emit(HomeState.loaded(_products));
  }
  void removeProduct(Product product) {
    _products.remove(product);
    emit(HomeState.loaded(_products));
  }
  void updateProduct(Product product) {
    final index = _products.indexWhere((element) => element == product);
    _products[index] = product;
    emit(HomeState.loaded(_products));
  }

}
