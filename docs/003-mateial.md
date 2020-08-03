# Material 组件教程

> 参考文章：[MDC Flutter 教程 1：Material 组件基础](https://codelabs.flutter-io.cn/codelabs/mdc-101-flutter-cn/index.html)。

## 一. 搭建初始 App

### 1.1 新建项目

在 VSCode 中按 `cmd + shift + p`，输入并选择 `Flutter: New Project`

1. 输入 `sample_03_material`，然后选择保存项目的目录；
2. 添加 `assets` 目录包含了项目要使用的图像素材；
3. 修改 `pubspec.yaml` 设置 `assets` 资源，代码如下：

   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/diamond.png
       - assets/0-0.jpg
       - assets/1-0.jpg
       - assets/2-0.jpg
   ... 以下内容省略
   ```

4. 删除 `/test` 目录；
5. 修改 `/lib/main.dart` 内容如下：

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

   > 运行程序可以看到一个空白的蓝色屏幕。

## 二. 页面路由

### 1.1 路由文件准备

1. 新建 `/lib/routes/home.dart` 作为 App 的首页，代码如下：

   ```dart
   import 'package:flutter/material.dart';

   class HomePage extends StatelessWidget {
     @override
     Widget build(BuildContext context) => Scaffold(
           body: Center(
             child: Text('Hello material'),
           ),
         );
   }
   ```

2. 新建 `/lib/routes/login.dart` 作为登录页面，代码如下：

   ```dart
   import 'package:flutter/material.dart';

   class LoginPage extends StatefulWidget {
     @override
     State<StatefulWidget> createState() => _LoginPageState();
   }

   class _LoginPageState extends State {
     @override
     Widget build(BuildContext context) => Scaffold(
           body: Center(
             child: Text('Login at here.'),
           ),
         );
   }
   ```

3. 新建 `/lib/app.dart`，负责创建并管理 App，代码如下：

   ```dart
   import 'package:flutter/material.dart';

   import 'routes/home.dart';
   import 'routes/login.dart';

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) => MaterialApp(
           title: 'Mateial',
           home: HomePage(),
           debugShowCheckedModeBanner: false,
         );
   }
   ```

4. 修改 `/lib/main.dart` 代码如下：

   ```dart
   import 'package:flutter/material.dart';

   import 'app.dart';

   void main() => runApp(MyApp());
   ```

   > 运行程序确认 `HomePage` 能够正常显示。

### 1.2 初始显示登录页面

1. 在 `MyApp` 中增加 `_getRoute` 方法，根据 `setting` 返回路由，代码如下：

   ```dart
   Route _getRoute(RouteSettings settings) {
     if (settings.name != '/login') {
       return null;
     }

     return MaterialPageRoute(
       settings: settings,
       builder: (context) => LoginPage(),
       fullscreenDialog: true,
     );
   }
   ```

2. 修改 `MyApp` 的 `build` 方法指定初始路由及生成路由使用的方法，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) => MaterialApp(
         title: 'Mateial',
         home: HomePage(),
         debugShowCheckedModeBanner: false,
         initialRoute: '/login',
         onGenerateRoute: _getRoute,
       );
   ```

   > 运行程序确认 `LoginPage` 能够正常显示。

## 三. 登录页面布局

### 3.1 页面图标和文本框

1. 修改 `_LoginPageState` 的 `build` 方法，显示 App 图片和文字说明，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: ListView(
             padding: EdgeInsets.symmetric(horizontal: 24.0),
             children: <Widget>[
               SizedBox(height: 80.0),
               Column(
                 children: <Widget>[
                   Image.asset('assets/diamond.png'),
                   SizedBox(height: 16),
                   Text('界面布局示例'),
                 ],
               ),
             ]),
       ),
     );
   }
   ```

2. 修改 `_LoginPageState` 定义两个私有成员用于记录用户输入的用户名和密码，代码如下：

   ```dart
   class _LoginPageState extends State {
     final _usernameController = TextEditingController();
     final _passwordController = TextEditingController();
   ```

3. 修改 `_LoginPageState` 的 `build` 方法，在 `Column` 下放追加两个 `TextField` 代码如下：

   ```dart
   SizedBox(height: 100),
   TextField(
     controller: _usernameController,
     decoration: InputDecoration(filled: true, labelText: '用户名：'),
   ),
   SizedBox(
     height: 12,
   ),
   TextField(
     controller: _passwordController,
     decoration: InputDecoration(filled: true, labelText: '密 码：'),
     obscureText: true,
   ),
   ```

   - `obscureText: true` 可以把用户输入自动替换为星号，一般用于输入密码。

   > 运行程序确认登录页面能正常显示，并且确认一下文本框的悬浮标签和 ink 波纹效果。

#### TextField 特性小结

1. TextField 的外观很容易被改变，为 `decoration` 指定一个 `InputDecoration` 值即可；
2. MDC 文本框默认会显示触摸反馈效果（称为 MDC 波纹或称 "ink" ）；
3. `FormField` 与它相似，其特别的特性是可以在 Form 里嵌入字段；

> 备注：在真机运行如果在两个文本框之前快速切换，输入窗口会有明显的闪动，**控制台会报自动布局约束警告**，影响用户体验。

### 3.2 添加按钮并实现页面跳转

- 修改 `_LoginPageState` 的 `build` 方法，在 `TextField` 下放追加一个 `ButtonBar` 代码如下：

  ```dart
  ButtonBar(
    alignment: MainAxisAlignment.center,
    children: <Widget>[
      FlatButton(
        child: Text('取消'),
        onPressed: () {
          _usernameController.clear();
          _passwordController.clear();
        },
      ),
      RaisedButton(
        child: Text('登录'),
        onPressed: () {
          if (_usernameController.text.trim() == 'admin' &&
              _passwordController.text == '123') {
            Navigator.pop(context);
          } else {
            print('用户名或密码错误。');
          }
        },
      ),
    ],
  ),
  ```

  - `_usernameController.clear()` 可以清空文本框中的内容；
  - `Navigator.pop(context);` 可以销毁当前登录页面（从 Navigation 栈中出栈）。

## 四. 首页

### 4.1 添加顶部导航栏

1. 修改 `HomePage` 的 `build` 方法，显示顶部导航栏，代码如下：

   ```dart
   class HomePage extends StatelessWidget {
     @override
     Widget build(BuildContext context) => Scaffold(
           appBar: AppBar(
             title: Text('界面布局示例'),
           ),
           ...
   ```

2. 通过 `leading` 在导航栏左侧添加一个按钮，代码如下：

   ```dart
   leading: IconButton(
     icon: Icon(
       Icons.menu,
       semanticLabel: '菜单',
     ),
     onPressed: () {
       print('点击菜单按钮');
     },
   ),
   ```

3. 通过 `actions` 在导航栏右侧添加两个个按钮，代码如下：

   ```dart
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
   ```

   - 有关 Material 风格的图标的详细信息，请参阅：<https://material.io/resources/icons/?style=baseline>。

### 4.2 网格卡片 GridView

1. 修改 `HomePage` 的 `build` 方法中的 `body`，将 `Center` 替换为 `GridVuiw`，代码如下：

   ```dart
   body: GridView.count(
     crossAxisCount: 2,
     padding: EdgeInsets.all(16),
     childAspectRatio: 8.0 / 9.0,
     children: <Widget>[
       Card(),
     ],
   ),
   ```

   - GridView 中的条目是有限的，所以需要调用 `count()`；
   - `crossAxisCount` 指定每横行展示多少条目；
   - `childAspectRatio` 以宽高比（宽除以高）的形式定义了条目的大小，GridView 里每个条目的大小默认都是一样的。

   > 提示：Cross axis 在 Flutter 中意思是**不可滚动的轴**，滚动的方向被称为**主轴**。

2. 在 Card 中增加图片、标题和描述文字，代码如下：

   ```dart
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
   ```

### 4.3 卡片集合

1. 在 `HomePage` 新建 `_buildGridCards` 方法负责构建网络卡片集合，初始代码如下：

   ```dart
   /// 构建网格卡片集合
   List<Card> _buildGridCards(int count) {
     List<Card> cards = List.generate(
         count,
         (index) => Card(
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
                   )
                 ],
               ),
             ));

     return cards;
   }
   ```

2. 修改 `build` 方法中的 `body`，使用 `_buildGridCards` 替换 `children` 内容，代码如下：

   ```dart
   body: GridView.count(
     crossAxisCount: 2,
     padding: EdgeInsets.all(16),
     childAspectRatio: 8.0 / 9.0,
     children: _buildGridCards(10),
   ```

### 4.4 产品数据

1. 新建 `models` 目录用户保存数据模型；
2. 复制 `sample_02_cupertino` 案例中使用的 `product.dart` 和 `products_repository.dart` 并稍作调整，直接从 `assets` 目录下加载图片资源，代码如下：

   ```dart
   String get assetName => 'assets/$id-0.jpg';
   ```

3. 在 `home.dart` 的顶部引入**产品模型**和**产品库存**数据，代码如下：

   ```dart
   import '../models/products_repository.dart';
   import '../models/product.dart';
   ```

4. 修改 `_buildGridCards` 使用产品数据返回卡片集合，代码如下：

   **注意：\_buildGridCards 的参数不在需要传入 count。**

   ```dart
   /// 构建网格卡片集合
   List<Card> _buildGridCards() {
     // 1. 加载所有商品
     List<Product> products = ProductsRepository.loadProducts(Category.all);

     if (products == null || products.isEmpty) {
       return const <Card>[];
     }

     // 2. 生成商品列表
     return products
         .map((product) => Card(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   AspectRatio(
                     aspectRatio: 18.0 / 11.0,
                     child: Image.asset(
                       product.assetName,
                       fit: BoxFit.fitWidth,
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(
                           product.name,
                           maxLines: 1,
                         ),
                         SizedBox(
                           height: 8,
                         ),
                         Text('￥ ' + product.price.toString())
                       ],
                     ),
                   )
                 ],
               ),
             ))
         .toList();
   }
   ```

   **提示**

   - 在修改代码时，可以边修改边运行查看效果；
   - `Image.asset` 的 `fit: BoxFit.fitWidth,` 可以按照图片宽度等比例裁切，让网格显示效果更整齐。

5. 修改 `build` 方法中的 `body` 中 `_buildGridCards` 方法的调用，代码如下：

   ```dart
   body: GridView.count(
     crossAxisCount: 2,
     padding: EdgeInsets.all(16),
     childAspectRatio: 8.0 / 9.0,
     children: _buildGridCards(),
   ```
