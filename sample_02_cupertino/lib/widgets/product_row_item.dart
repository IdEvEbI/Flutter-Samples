import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../style.dart';

/// 商品行元素
class ProductRowItem extends StatelessWidget {
  final Product product;
  final int index;
  final bool lastItem;

  const ProductRowItem({this.product, this.index, this.lastItem});

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
      child: Row(
        children: <Widget>[
          // 商品图片
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: Styles.productRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    '\$${product.price}',
                    style: Styles.productRowItemPrice,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Divider(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }
}
