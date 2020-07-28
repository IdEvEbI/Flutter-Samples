# 第一个 Flutter App

> 参考文章：[编写你的第一个 Flutter App](https://codelabs.flutter-io.cn/codelabs/first-flutter-app-pt1-cn/index.html)。

## 一. 新建项目

在 VSCode 中按 `cmd + shift + p`，输入并选择 `Flutter: New Project`

- 输入 `sample_01_hello_flutter`，然后选择保存项目的目录；
- 在 `/lib/main.dart` 中点击 Run 启动模拟器并查看效果。

## 二. Hello Widget

修改 `/lib/main.dart` 代码如下：

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hello Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('第一个 Flutter App'),
        ),
        body: const Center(
          child: const Text('Hello Widget'),
        ),
      ),
    );
  }
}
```

代码小结

- Flutter 中大多数东西都是 widget；
- widget 提供的 `build()` 方法用来根据内部较低级别的 widgets 显示自己；
- `Scaffold` 提供了默认的**导航栏**、**标题**和包含**主屏幕 widget 树的 body 属性**，widget 树可以很复杂；
- `body` 包含 `Center`，`Center` 包含 `Text`，`Center` 可以将其子 widget 树显示到屏幕中心。

> 提示：在 VSCode 中按 `cmd + 单击` 可以直接查看源程序。
