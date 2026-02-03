import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String slug,
    required int price,
    required String description,
    required Category category,
    required List<String> images,
    required String creationAt,
    required String updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
