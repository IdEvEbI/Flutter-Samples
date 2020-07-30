import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

/// 商品行元素
class ProductRowItem extends StatelessWidget {
  final Product product;
  final int index;
  final bool lastItem;

  const ProductRowItem({this.product, this.index, this.lastItem});

  @override
  Widget build(BuildContext context) {
    return Text(product.name);
  }
}
