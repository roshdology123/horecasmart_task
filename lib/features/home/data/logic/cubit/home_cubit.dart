import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:horecasmart_task/features/product/data/models/product.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore _firebaseFirestore;
  List<Product> _allProducts = [];
  String _selectedCategory = 'All';

  HomeCubit(this._firebaseFirestore) : super(const HomeState.initial());

  Future<void> getProducts() async {
    emit(const HomeState.loading());
    try {
      final productsSnapshot = await _firebaseFirestore.collection('products').get();
      _allProducts = productsSnapshot.docs
          .map((doc) => Product.fromJson(doc.data()))
          .toList();
      _filterProducts();
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _filterProducts();
  }

  void _filterProducts() {
    if (_selectedCategory == 'All') {
      emit(HomeState.loaded(_allProducts));
    } else {
      final filteredProducts = _allProducts
          .where((product) => product.category == _selectedCategory)
          .toList();
      emit(HomeState.loaded(filteredProducts));
    }
  }

  List<Product> getTopRatedProducts(int count) {
    final sortedProducts = List<Product>.from(_allProducts)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sortedProducts.take(count).toList();
  }
}
