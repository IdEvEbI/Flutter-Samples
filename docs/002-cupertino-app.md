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
         home: new Container(color: Colors.red),
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
     home: new CupertinoStoreHomePage(),
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

       ... 以下内容省略，详见 pubspec.yaml 内容
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

   ... 以下内容省略，详见 style.dart 内容
   ```

2. 在 `app.dart` 引入 `style.dart` 代码如下：

   ```dart
   import 'style.dart';
   ```
