import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import '../widgets/product_row_item.dart';

/// 商品列表 Tab 页面
class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: Consumer<AppStateModel>(
          builder: (context, model, child) {
            final products = model.getProducts();

            return CustomScrollView(
              semanticChildCount: products.length,
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('商品列表'),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index < products.length) {
                        return ProductRowItem(
                          index: index,
                          product: products[index],
                          lastItem: index == products.length - 1,
                        );
                      } else {
                        return null;
                      }
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
