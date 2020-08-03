import 'package:flutter/foundation.dart';

/// 商品分类
enum Category {
  all,
  accessories,
  clothing,
  home,
}

/// 商品
class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.price,
  })  : assert(category != null, 'category must not be null'),
        assert(id != null, 'id must not be null'),
        assert(isFeatured != null, 'isFeatured must not be null'),
        assert(name != null, 'name must not be null'),
        assert(price != null, 'price must not be null');

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  String get assetName => 'assets/$id-0.jpg';

  @override
  String toString() => '$name (id=$id)';
}
