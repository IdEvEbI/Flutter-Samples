# Material 组件教程

> 参考文章：[MDC Flutter 教程 1：Material 组件基础](https://codelabs.flutter-io.cn/codelabs/mdc-101-flutter-cn/index.html)。

## 一. 搭建初始 App

### 1.1 新建项目

在 VSCode 中按 `cmd + shift + p`，输入并选择 `Flutter: New Project`

1. 输入 `sample_03_material`，然后选择保存项目的目录；
2. 添加 `assets` 目录包含了项目要使用的图像素材；
3. 删除 `/test` 目录；
4. 修改 `/lib/main.dart` 内容如下：

   ```dart
   import 'package:flutter/material.dart';

   void main() => runApp(MyApp());

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) => Container(
           color: Colors.blue,
         );
   }
   ```

5. 运行可以看到一个空白的蓝色屏幕。
