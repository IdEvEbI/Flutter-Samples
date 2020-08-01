# 构建 iOS 风格的应用

> 参考文章：[使用 Flutter 构建 iOS 风格的应用](https://codelabs.flutter-io.cn/codelabs/flutter-cupertino-cn/index.html)。

Material 设计风格是为全平台设计的，可以保证 App 在任何平台上的运行效果一致。但如果想要让 App 更符合 iOS 的风格，则需要用到 Cupertino 库。

提示：虽然在 iOS 和 Android 上都能正常运行 Cupertino 搭建的 App，但由于授权原因，Cupertino 在 Android 上不能展示它应有的字体。所以我们需要保证开发的 Cupertino App 运行在 iOS 的设备上。

## 一. 搭建初始 Cupertino App

### 1.1 新建项目

在 VSCode 中按 `cmd + shift + p`，输入并选择 `Flutter: New Project`

1. 输入 `sample_02_cupertino`，然后选择保存项目的目录；
2. 在 `/lib/main.dart` 中点击 Run 启动模拟器并查看效果。

### 1.2 创建 App 和首页

1. 新建 `app.dart` 作为 App 的**主程序**并输入以下代码：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:flutter/material.dart';

   /// 仓库 App 类
   class CupertinoStoreApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return CupertinoApp(
         home: Container(color: Colors.red),
       );
     }
   }
   ```

   - `Container` 是 `StatelessWidget` 的子类，常在布局中用于包装其他子 Widget。

2. 删除 `main.dart` 中的所有内容并输入以下代码：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:flutter/services.dart';

   import 'app.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();

     SystemChrome.setPreferredOrientations(
         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

     return runApp(CupertinoStoreApp());
   }
   ```

   - 使用 `ensureInitialized` 的原因请参考 [stack overflow](https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse) 描述。
   - `services` 可以在 App 中使用一些平台服务，比如剪贴板、设置屏幕旋转等；
   - `portraitUp` 和 `portraitDown` 限制程序只支持竖屏；

3. 在 `app.dart` 中新建 `CupertinoStoreHomePage` 作为 App 首页，代码如下：

   ```dart
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
   ```

4. 修改 `CupertinoStoreApp` 的 `build` 方法，使用 `CupertinoStoreHomePage` 实例替换空容器，代码如下：

   ```dart
   return CupertinoApp(
     home: CupertinoStoreHomePage(),
   );
   ```

### 1.3 添加开发依赖包

1. 修改 `pubspec.yaml` 添加项目需要使用的包，代码如下：

   ```yaml
   dependencies:
     flutter:
       sdk: flutter

     cupertino_icons: ^0.1.3
     intl: ^0.16.1
     provider: ^2.0.0+1
     shrine_images: ^1.0.0
   ```

2. 保存 `pubspec.yaml`，VSCode 会自动下载对应的开发依赖包，其中包括：

   - intl：提供国际化和本地化支持；
   - provider：提供用来跨界面管理 state 的简单办法；
   - shrine_images：提供示例程序需要使用的图片素材。

   > 备忘：这种使用图品素材的方式倒是第一次遇到，后续还需留意 Flutter 中关于图片素材的使用方式。

3. 继续修改 `pubspec.yaml` 添加需要使用的图片素材，代码如下：

   ```yaml
   flutter:
     assets:
       - packages/shrine_images/0-0.jpg
       - packages/shrine_images/1-0.jpg
       - packages/shrine_images/2-0.jpg
       - packages/shrine_images/3-0.jpg
       - packages/shrine_images/4-0.jpg

       ... 以下内容省略，详见 pubspec.yaml
   ```

### 1.4 定义样式常量

1. 新建 `style.dart`，并输入以下代码：

   ```dart
   import 'package:flutter/cupertino.dart';

   abstract class Styles {
     static const productRowItemName = TextStyle(
       color: Color.fromRGBO(0, 0, 0, 0.8),
       fontSize: 18,
       fontStyle: FontStyle.normal,
       fontWeight: FontWeight.normal,
     );

   ... 以下内容省略，详见 style.dart
   ```

2. 在 `app.dart` 引入 `style.dart` 代码如下：

   ```dart
   import 'style.dart';
   ```

## 二. 添加 TabBar

1. 在 `CupertinoStoreHomePage` 中添加 `_pageScaffoldChild` 私有方法根据索引返回**临时**容器部件，代码如下：

   ```dart
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
   ```

2. 修改 `CupertinoStoreHomePage` 的 `build` 方法，使用 `CupertinoTabScaffold` 替代 `CupertinoPageScaffold`，实现 App 底部的 TabBar，代码如下：

   ```dart
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
   ```

## 三. 添加状态 (state) 管理

### 3.1 商品类和商品库存类

1. 新建 `lib/model/product.dart` 用于定义商品分类及商品属性，代码如下：

   ```dart
   import 'package:flutter/foundation.dart';

   /// 商品分类
   enum Category {
     all,
     accessories,
     clothing,
     home,
   }

   /// 商品
   class Product {
     const Product({
       @required this.category,
       @required this.id,
       @required this.isFeatured,
       @required this.name,
       @required this.price,
     })  : assert(category != null, 'category must not be null'),
           assert(id != null, 'id must not be null'),
           assert(isFeatured != null, 'isFeatured must not be null'),
           assert(name != null, 'name must not be null'),
           assert(price != null, 'price must not be null');

     final Category category;
     final int id;
     final bool isFeatured;
     final String name;
     final int price;

     String get assetName => '$id-0.jpg';
     String get assetPackage => 'shrine_images';

     @override
     String toString() => '$name (id=$id)';
   }
   ```

2. 新建 `lib/model/products_repository.dart`，用于定义商品库存数据，代码如下：

   ```dart
   import 'product.dart';

   class ProductsRepository {
     static const _allProducts = <Product>[
       Product(
           category: Category.accessories,
           id: 0,
           isFeatured: true,
           name: 'Vagabond sack',
           price: 120),

       ... 内容省略，详见 products_repository.dart
     ];

     static List<Product> loadProducts(Category category) =>
         category == Category.all
             ? _allProducts
             : _allProducts.where((e) => e.category == category).toList();
   }
   ```

   > 提示：当前示例把库存数据写死了，后续需要：① 网络获取 ② 序列化数据 ③ 字典转模型...

### 3.2 商品模型类

1. 新建 `lib/model/app_state_model.dart` 用于定义商品模型封装业务逻辑，代码如下：

   ```dart
   class AppStateModel extends foundation.ChangeNotifier {
     // 所有可用商品
     List<Product> _availableProducts;

     /// 当前选中商品类别
     Category _selectedCategory = Category.all;

     /// 当前购物车信息：IDs 和数量
     final _productsInCart = <int, int>{};

     Category get selectedCategory => _selectedCategory;
     Map<int, int> get productsInCart => Map.from(_productsInCart);

     /// 购物车中的商品总数
     int get totalCartQuantity => _productsInCart.values
         .fold(0, (previousValue, element) => previousValue + element);

     ... 内容省略，详见 app_state_model.dart
   ```

   > **体会**：要确定一门语言的基础语法掌握的是否能够支撑工作，写一遍完整的业务代码是个好办法；
   > **提示**：`AppStateModel` 继承自 `foundation.ChangeNotifier`，代码中使用 `notifyListeners` 通知监听者。

2. 修改 `lib/main.dart` 提供状态数据并添加监听，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:flutter/services.dart';
   import 'package:provider/provider.dart';

   import 'app.dart';
   import 'model/app_state_model.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();

     SystemChrome.setPreferredOrientations(
         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

     return runApp(ChangeNotifierProvider<AppStateModel>(
       builder: (context) => AppStateModel()..loadProducts(),
       child: CupertinoStoreApp(),
     ));
   }
   ```

   - `provider` 的 `ChangeNotifierProvider` 能够监听到 `AppStateModel` 因变化而发出的通知；
   - 在 widget 的最上层实现 `AppStateModel` 可以保证状态在整个 App 中都可以被访问。

## 四. 商品列表

### 4.1 显示商品列表 Tab 页

1. 新建 `lib/widgets/product_list_tab.dart` 用于显示整个商品的 Tab 页，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:provider/provider.dart';

   import '../model/app_state_model.dart';

   /// 商品列表 Tab 页
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
   ```

2. 修改 `lib/app.dart` 引入 `product_list_tab.dart` 并修改第一个 Tab 页，代码如下：

   ```dart
   import 'widgets/product_list_tab.dart';

   ... 以下内容省略，详见 app.dart

     Widget _pageScaffoldChild(int index) {
       switch (index) {
         case 0:
           return ProductListTab();
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
   ```

   > 运行程序，确认**商品 Tab 页**能够显示一个带导航栏的空页面。

### 4.2 显示商品明细行

1. 新建 `lib/widgets/product_row_item.dart` 用于定义一行商品显示，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:flutter/material.dart';

   import '../model/product.dart';

   /// 商品行元素
   class ProductRowItem extends StatelessWidget {
     final Product product;
     final int index;
     final bool lastItem;

     const ProductRowItem({this.product, this.index, this.lastItem});

     @override
     Widget build(BuildContext context) {
       return Text(product.name);
     }
   }
   ```

   > 提示：以上代码仅定义了属性和构造函数，并且简单地显示了一下产品名称，有关界面细节稍后调整。

2. 修改 `ProductListTab` 的 `build` 方法，增加**商品行元素**的显示，代码如下：

   ```dart
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
   ```

   > 运行程序，确认**商品 Tab 页**能够显示所有商品的名称，并且支持滚动。

### 4.3 商品明细行布局

1. 修改 `ProductRowItem` 的 `build` 方法，实现一个完整商品行的布局，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     final row = SafeArea(
       top: false,
       bottom: false,
       minimum: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
       child: Row(
         children: <Widget>[
           // 商品图片
           ClipRRect(
             borderRadius: BorderRadius.circular(4),
             child: Image.asset(
               product.assetName,
               package: product.assetPackage,
               fit: BoxFit.cover,
               width: 76,
               height: 76,
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 12),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(
                     product.name,
                     style: Styles.productRowItemName,
                   ),
                   const Padding(padding: EdgeInsets.only(top: 8)),
                   Text(
                     '\$${product.price}',
                     style: Styles.productRowItemPrice,
                   )
                 ],
               ),
             ),
           ),
         ],
       ),
     );

     return row;
   }
   ```

2. 修改 `ProductRowItem` 的 `build` 方法末尾的 `return row;`，在**每个商品之间增加一条分隔线**（末尾商品除外），代码如下：

   ```dart
   if (lastItem) {
     return row;
   }

   return Column(
     children: <Widget>[
       row,
       Padding(
         padding: const EdgeInsets.only(
           left: 100,
           right: 16,
         ),
         child: Divider(
           height: 1,
           color: Styles.productRowDivider,
         ),
       ),
     ],
   );
   ```

### 4.4 添加到购物车

1. 修改 `ProductRowItem` 的 `build` 方法，在 `row` 的 `Expanded` 后面增加一个 `CupertinoButton` 作为**添加到购物车按钮**，代码如下：

   ```dart
   CupertinoButton(
     padding: EdgeInsets.zero,
     child: const Icon(
       CupertinoIcons.plus_circled,
       semanticLabel: '加入购物车',
     ),
     onPressed: () {
       print('将 ${product.name} 加入购物车');
     },
   ),
   ```

2. 实现 `onPressed` 方法，代码如下：

   ```dart
   onPressed: () {
     print('将 ${product.name} 加入购物车');

     final model = Provider.of<AppStateModel>(context);
     model.addProductToCart(product.id);

     print('购物车：${model.productsInCart}');
   },
   ```

   > 运行程序，在调试控制台确认 `onPressed` 方法能够被正确执行。

## 五. 产品搜索

### 5.1 显示商品搜索 Tab 页

1. 新建 `/lib/widgets/search_tab.dart` 用于显示商品搜索的 Tab 页，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';

   class SearchTab extends StatefulWidget {
     @override
     State<StatefulWidget> createState() => _SearchTabState();
   }

   class _SearchTabState extends State<SearchTab> {
     @override
     Widget build(BuildContext context) {
       return CustomScrollView(
         slivers: <Widget>[
           CupertinoSliverNavigationBar(
             largeTitle: Text('搜索'),
           ),
         ],
       );
     }
   }
   ```

2. 修改 `lib/app.dart` 引入 `search_tab.dart` 并修改第二个 Tab 页，代码如下：

   ```dart
   import 'widgets/search_tab.dart';

   ... 以下内容省略，详见 app.dart

     Widget _pageScaffoldChild(int index) {
       switch (index) {
         case 0:
           return ProductListTab();
         case 1:
           return SearchTab();
         case 2:
           return Container(
             color: Colors.green,
           );
         default:
           throw ('$index is out of range.');
       }
     }
   ```

### 5.2 定义私有成员记录搜索状态

1. 定义 `_SearchTabState` 的私有成员用于保持搜索状态，代码如下：

   ```dart
   TextEditingController _controller;
   FocusNode _focusNode;
   String _terms = '';
   ```

2. 重写 `initState` 方法实例化私有成员，代码如下：

   ```dart
   @override
   void initState() {
     super.initState();

     _controller = TextEditingController()
       ..addListener(() {
         setState(() {
           _terms = _controller.text;
         });
       });
     _focusNode = FocusNode();
   }
   ```

3. 重写 `dispose` 方法释放资源，代码如下：

   ```dart
   @override
   void dispose() {
     _focusNode.dispose();
     _controller.dispose();

     super.dispose();
   }
   ```

   > 提示：以上代码感受到了 iOS 开发的味道。

### 5.3 显示搜索栏

1. 新建 `/lib/widgets/search_bar.dart` 用于显示商品搜索栏，代码如下：

   ```dart
   import 'package:flutter/material.dart';

   /// 搜索条
   class SearchBar extends StatelessWidget {
     final TextEditingController controller;
     final FocusNode focusNode;

     const SearchBar({
       @required this.controller,
       @required this.focusNode,
     });

     @override
     Widget build(BuildContext context) => Container(
           color: Colors.red,
           height: 64,
         );
   }
   ```

2. 修改 `search_tab.dart` 增加文件引入，代码如下：

   ```dart
   import 'package:flutter/material.dart';

   import 'search_bar.dart';
   import '../style.dart';
   ```

3. 修改 `_SearchTabState` 的 `build` 方法显示搜索栏，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     return DecoratedBox(
       decoration: const BoxDecoration(
         color: Colors.blue,
       ),
       child: SafeArea(
         child: Column(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8),
               child: SearchBar(
                 controller: _controller,
                 focusNode: _focusNode,
               ),
             )
           ],
         ),
       ),
     );
   }
   ```

   > 运行程序，可以看到蓝色背景下有一块用于显示搜索栏的红色区域。

### 5.4 搜索栏布局

1. 修改 `search_bar.dart` 的文件引入，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import '../style.dart';
   ```

2. 修改 `SearchBar` 的 `build` 方法实现搜索栏布局，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     return DecoratedBox(
       decoration: BoxDecoration(
         color: Styles.searchBackground,
         borderRadius: BorderRadius.circular(10),
       ),
       child: Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 4,
           vertical: 8,
         ),
         child: Row(
           children: <Widget>[
             const Icon(
               CupertinoIcons.search,
               color: Styles.searchIconColor,
             ),
             Expanded(
               child: CupertinoTextField(
                 controller: controller,
                 focusNode: focusNode,
                 style: Styles.searchText,
                 cursorColor: Styles.searchCursorColor,
               ),
             ),
             GestureDetector(
               onTap: controller.clear,
               child: const Icon(
                 CupertinoIcons.clear_thick_circled,
                 color: Styles.searchIconColor,
               ),
             ),
           ],
         ),
       ),
     );
   }
   ```

### 5.5 搜索商品并显示结果

1. 修改 `search_tab.dart` 的文件引入，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:provider/provider.dart';

   import '../model/app_state_model.dart';
   import 'product_row_item.dart';
   import 'search_bar.dart';

   import '../style.dart';
   ```

2. 修改 `_SearchTabState` 的 `build` 方法实现搜索结果布局，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     final model = Provider.of<AppStateModel>(context);
     final results = model.search(_terms);

     return DecoratedBox(
       decoration: const BoxDecoration(
         color: Styles.scaffoldBackground,
       ),
       child: SafeArea(
         child: Column(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8),
               child: SearchBar(
                 controller: _controller,
                 focusNode: _focusNode,
               ),
             ),
             Expanded(
               child: ListView.builder(
                 itemBuilder: (context, index) => ProductRowItem(
                   index: index,
                   product: results[index],
                   lastItem: index == results.length - 1,
                 ),
                 itemCount: results.length,
               ),
             ),
           ],
         ),
       ),
     );
   }
   ```

   > 运行程序，搜索功能已经能够正常使用，这是因为在 [3.2 商品模型类] 已经实现过搜索的业务逻辑。

## 六. 客户信息和购物车

### 6.1 显示购物车 Tab 页

1. 新建 `/lib/widgets/shopping_cart_tab.dart` 用于显示购物车的 Tab 页，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:provider/provider.dart';

   import '../model/app_state_model.dart';

   class ShoppingCartTab extends StatefulWidget {
     @override
     State<StatefulWidget> createState() => _ShoppingCartTabState();
   }

   class _ShoppingCartTabState extends State<ShoppingCartTab> {
     @override
     Widget build(BuildContext context) => Consumer<AppStateModel>(
           builder: (context, model, child) => CustomScrollView(
             slivers: <Widget>[
               CupertinoSliverNavigationBar(
                 largeTitle: Text('购物车'),
               ),
             ],
           ),
         );
   }
   ```

   - `provider` 中的 `Consumer` 可以用来协助 `state` 管理；
   - 购物车 Tab 页 是一个 stateful widget，因为它要负责掌控需要购买的产品列表和客户信息。

2. 修改 `lib/app.dart` 引入 `shopping_cart_tab.dart` 并修改第三个 Tab 页，代码如下：

   ```dart
   import 'widgets/search_tab.dart';

   ... 以下内容省略，详见 app.dart

     Widget _pageScaffoldChild(int index) {
       switch (index) {
         case 0:
           return ProductListTab();
         case 1:
           return SearchTab();
         case 2:
           return ShoppingCartTab();
         default:
           throw ('$index is out of range.');
       }
     }
   ```

### 6.2 客户信息布局

1. 在 `_ShoppingCartTabState` 中定义客户信息属性，代码如下：

   ```dart
   String name;
   String email;
   String location;
   String pin;
   DateTime dateTime = DateTime.now();
   ```

2. 在 `_ShoppingCartTabState` 中定义 `_buildTextField` 方法实现**姓名**、**邮件**和**地址**的界面布局，代码如下：

   ```dart
   CupertinoTextField _buildTextField(int index) {
     if (index > 2) {
       return null;
     }

     String placeholder = '请输入';
     IconData icon;

     if (index == 0) {
       placeholder += '姓名';
       icon = CupertinoIcons.person_solid;
     } else if (index == 1) {
       placeholder += '邮箱';
       icon = CupertinoIcons.mail_solid;
     } else {
       placeholder += '地址';
       icon = CupertinoIcons.location_solid;
     }

     return CupertinoTextField(
       prefix: Icon(
         icon,
         color: CupertinoColors.lightBackgroundGray,
         size: 28,
       ),
       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
       clearButtonMode: OverlayVisibilityMode.editing,
       autocorrect: false,
       decoration: const BoxDecoration(
         border: Border(
           bottom: BorderSide(width: 10, color: CupertinoColors.inactiveGray),
         ),
       ),
       placeholder: placeholder,
     );
   }
   ```

3. 在 `_ShoppingCartTabState` 中定义 `_buildSliverChildBuilderDelegate` 实现输入文本框布局的代理，代码如下：

   ```dart
   SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
       AppStateModel model) {
     return SliverChildBuilderDelegate((context, index) {
       if (index > 2) {
         return null;
       }
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
         child: _buildTextField(index),
       );
     });
   }
   ```

4. 修改 `build` 方法，通过 `delegate` 实现 `SliverList` 的布局，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) => Consumer<AppStateModel>(
         builder: (context, model, child) => CustomScrollView(
           slivers: <Widget>[
             CupertinoSliverNavigationBar(
               largeTitle: Text('购物车'),
             ),
             SliverSafeArea(
               top: false,
               minimum: const EdgeInsets.only(top: 4),
               sliver: SliverList(
                 delegate: _buildSliverChildBuilderDelegate(model),
               ),
             ),
           ],
         ),
       );
   ```

### 6.3 增加日期选择

1. 在 `/lib/widgets/shopping_cart_tab.dart` 顶部增加文件引入和常量定义，代码如下：

   ```dart
   import 'package:flutter/cupertino.dart';
   import 'package:intl/intl.dart';
   import 'package:provider/provider.dart';

   import '../model/app_state_model.dart';
   import '../style.dart';

   const double _kDateTimePickerHeight = 218;
   ```

2. 新建 `_buildDateTimePicker` 实现日期选择器的界面布局，代码如下：

   ```dart
   Widget _buildDateTimePicker(BuildContext context) => Column(
         children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Icon(
                     CupertinoIcons.clock,
                     color: CupertinoColors.lightBackgroundGray,
                     size: 28,
                   ),
                   SizedBox(
                     width: 6,
                   ),
                   Text(
                     '发货日期',
                     style: Styles.deliveryTimeLabel,
                   )
                 ],
               ),
               Text(
                 DateFormat.yMd().format(dateTime),
                 style: Styles.deliveryTimeLabel,
               ),
             ],
           ),
           Container(
             height: _kDateTimePickerHeight,
             child: CupertinoDatePicker(
               mode: CupertinoDatePickerMode.dateAndTime,
               initialDateTime: dateTime,
               onDateTimeChanged: (value) {
                 setState(() {
                   dateTime = value;
                 });
               },
             ),
           ),
         ],
       );
   ```

3. 修改 `_buildSliverChildBuilderDelegate` 方法在第 3 行显示日期选择器，代码如下：

   ```dart
   SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
       AppStateModel model) {
     return SliverChildBuilderDelegate((context, index) {
       if (index > 3) {
         return null;
       }
       if (index == 3) {
         return Padding(
           padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
           child: _buildDateTimePicker(context),
         );
       }
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
         child: _buildTextField(index),
       );
     });
   }
   ```

   - `CupertinoDatePicker` 虽然具有 iOS 控件的风格，但是暂时还没找到支持中文的方法；
   - `DateFormat` 还需要细化看一下 API 以确认如何按照中文习惯显示日期。

### 6.4 显示购物车商品

1. 新建 `shopping_cart_item.dart` 用于显示商品明细行，首先实现属性定义和构造函数，代码如下：

   ```dart
   import 'package:flutter/material.dart';
   import 'package:intl/intl.dart';

   import '../model/product.dart';
   import '../style.dart';

   class ShoppingCartItem extends StatelessWidget {
     final Product product;
     final int index;
     final bool lastItem;
     final int quantity;
     final NumberFormat formatter;

     const ShoppingCartItem({
       @required this.index,
       @required this.product,
       @required this.lastItem,
       @required this.quantity,
       @required this.formatter,
     });

     @override
     Widget build(BuildContext context) => Container(
           height: 64,
           color: Colors.red,
         );
   }
   ```

2. 在 `shopping_cart_tab.dart` 顶部增加引用和常量定义，代码如下：

   ```dart
   import './shopping_cart_item.dart';

   final _currencyFormat = NumberFormat.currency(symbol: '\￥');
   ```

3. 修改 `_buildSliverChildBuilderDelegate` 代码结构，以方便增加商品行显示，代码如下：

   ```dart
   SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
       AppStateModel model) {
     return SliverChildBuilderDelegate((context, index) {
       // 1. 固定行 - 用户信息和发货日期
       if (index < 3) {
         return Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child: _buildTextField(index),
         );
       } else if (index == 3) {
         return Padding(
           padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
           child: _buildDateTimePicker(context),
         );
       }

       // 2. 购物车商品行
     });
   }
   ```

4. 扩展 `_buildSliverChildBuilderDelegate` 方法，完成购物车商品行显示，代码如下：

   ```dart
   // 2. 购物车商品行
   final productIndex = index - 4;

   print('购物车种类： ${model.productsInCart.keys.length}');

   if (model.productsInCart.length > productIndex) {
     return ShoppingCartItem(
       index: index,
       product: model
           .getProductById(model.productsInCart.keys.toList()[productIndex]),
       quantity: model.productsInCart.values.toList()[productIndex],
       lastItem: productIndex == model.productsInCart.length - 1,
       formatter: _currencyFormat,
     );
   }

   return null;
   ```

5. 修改 `ShoppingCartItem` 的 `build` 方法，完成商品行界面布局，代码如下：

   ```dart
   @override
   Widget build(BuildContext context) => SafeArea(
       top: false,
       bottom: false,
       child: Padding(
         padding: const EdgeInsets.only(
           left: 16,
           top: 8,
           bottom: 8,
           right: 8,
         ),
         child: Row(
           children: <Widget>[
             ClipRRect(
               borderRadius: BorderRadius.circular(4),
               child: Image.asset(
                 product.assetName,
                 package: product.assetPackage,
                 fit: BoxFit.cover,
                 width: 40,
                 height: 40,
               ),
             ),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(
                           product.name,
                           style: Styles.productRowItemName,
                         ),
                         Text(
                           '${formatter.format(quantity * product.price)}',
                           style: Styles.productRowItemName,
                         ),
                       ],
                     ),
                     const SizedBox(
                       height: 4,
                     ),
                     Text(
                       '${quantity > 1 ? '$quantity x ' : ''}'
                       '${formatter.format(product.price)}',
                       style: Styles.productRowItemPrice,
                     )
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
     );
   ```

6. 扩展 `_buildSliverChildBuilderDelegate` 方法，完成订单总额显示，代码如下：

   ```dart
   else if (model.productsInCart.keys.length == productIndex &&
       model.productsInCart.isNotEmpty) {
     // 3. 显示订单总额
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Row(
         children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               Text(
                 'Shipping '
                 '${_currencyFormat.format(model.shippingCost)}',
                 style: Styles.productRowItemPrice,
               ),
               const SizedBox(height: 6),
               Text(
                 'Tax ${_currencyFormat.format(model.tax)}',
                 style: Styles.productRowItemPrice,
               ),
               const SizedBox(height: 6),
               Text(
                 'Total  ${_currencyFormat.format(model.totalCost)}',
                 style: Styles.productRowTotal,
               ),
             ],
           ),
         ],
         mainAxisAlignment: MainAxisAlignment.end,
       ),
     );
   }
   ```

## 七. 总结

通过本案例演练，发现 Flutter 的开发与 iOS 有太多相似之处，诸如：

1. TabBar + Navigator 的布局组合；
2. ListView 是布局基础部件，使用 delegate 为 ListView 提供行部件；
3. 在 `initState` 中初始化私有成员，在 `dispose` 中释放资源。

另外，通过 `provider` 来实现跨界面的 state 管理真得是非常方便。
