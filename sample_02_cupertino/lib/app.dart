import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'style.dart';

/// 仓库 App 类
class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoStoreHomePage(),
    );
  }
}

/// 仓库首页
class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(Object context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('商品'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              title: Text('搜索'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              title: Text('购物车'),
            ),
          ],
        ),
        tabBuilder: (context, index) => CupertinoTabView(
          builder: (context) => CupertinoPageScaffold(
            child: _pageScaffoldChild(index),
          ),
        ),
      );

  Widget _pageScaffoldChild(int index) {
    switch (index) {
      case 0:
        return Container(
          color: Colors.red,
        );
      case 1:
        return Container(
          color: Colors.blue,
        );
      case 2:
        return Container(
          color: Colors.green,
        );
      default:
        throw ('$index is out of range.');
    }
  }
}
