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
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          childAspectRatio: 8.0 / 9.0,
          children: <Widget>[
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 18.0 / 11.0,
                    child: Image.asset('assets/diamond.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('标题'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('详细信息')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
