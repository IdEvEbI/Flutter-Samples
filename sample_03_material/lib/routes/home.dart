import 'package:flutter/material.dart';

import '../models/products_repository.dart';
import '../models/product.dart';
import '../supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('界面布局示例'),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            print('点击菜单按钮');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              print('点击搜索按钮');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
            ),
            onPressed: () {
              print('点击过滤按钮');
            },
          ),
        ],
      ),
      body: AsymmetricView(
        products: ProductsRepository.loadProducts(Category.all),
      ));
}
