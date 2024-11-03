import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:horecasmart_task/features/product/data/models/product.dart';

part 'cart_item_model.g.dart';

part 'cart_item_model.freezed.dart';
@freezed
class CartItemModel with _$CartItemModel {
  factory CartItemModel({
    @ProductConverter() required Product product,
    required int quantity,
    required double totalPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);
}
class ProductConverter implements JsonConverter<Product, Map<String, dynamic>> {
  const ProductConverter();

  @override
  Product fromJson(Map<String, dynamic> json) => Product.fromJson(json);

  @override
  Map<String, dynamic> toJson(Product product) => product.toJson();
}
