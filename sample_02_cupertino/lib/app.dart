import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'style.dart';

/// 仓库 App 类
class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: new CupertinoStoreHomePage(),
    );
  }
}

/// 仓库首页
class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: const Text('商品列表')),
      child: Container(color: Colors.blue),
    );
  }
}
