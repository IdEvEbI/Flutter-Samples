import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('界面布局示例'),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel: '菜单',
            ),
            onPressed: () {
              print('点击菜单按钮');
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: '搜索',
              ),
              onPressed: () {
                print('点击搜索按钮');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.tune,
                semanticLabel: '过滤',
              ),
              onPressed: () {
                print('点击过滤按钮');
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Hello material'),
        ),
      );
}
