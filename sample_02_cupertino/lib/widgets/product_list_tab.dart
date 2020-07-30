import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';

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
                )
              ],
            );
          },
        ),
      );
}
