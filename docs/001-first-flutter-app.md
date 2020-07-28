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

> 代码小结

1. Flutter 中大多数东西都是 widget；
2. widget 提供的 `build()` 方法用来根据内部较低级别的 widgets 显示自己；
3. `Scaffold` 提供了默认的**导航栏**、**标题**和包含**主屏幕 widget 树的 body 属性**，widget 树可以很复杂；
4. `body` 包含 `Center`，`Center` 包含 `Text`，`Center` 可以将其子 widget 树显示到屏幕中心。

> 提示：在 VSCode 中按 `cmd + 单击` 可以直接查看源程序。

## 三. 使用包（package）

1. 访问 [pub.dev 的 english_words](https://pub.flutter-io.cn/packages/english_words) 主页查看`english_words` 包的相关信息；

2. 修改 `pubspec.yaml` 如下：

   ```yaml
   dependencies:
     flutter:
       sdk: flutter

     cupertino_icons: ^0.1.3
     english_words: ^3.1.5
   ```

3. 保存 `pubspec.yaml`，VSCode 会自动下载 `english_words` 包，并修改 `.packages` 文件；

4. 修改 `main.dart` 文件如下：

   ```dart
   // 引入 english_word 包
   import 'package:english_words/english_words.dart';

   ...

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       final wordPair = new WordPair.random(); // 新增

       return new MaterialApp(
         title: 'Hello Flutter',
         home: new Scaffold(
           appBar: new AppBar(
             title: const Text('第一个 Flutter App'),
           ),
           body: new Center( // const → new
             child: new Text(wordPair.asPascalCase), // 替换
           ),
         ),
       );
     }
   }
   ```

> 提示：Center 的子对象已经不是常量，因此不能使用 `const` 修饰，否则会报错。

## 四. Stateful Widget

- `StatelessWidget` 是**不可变的**，这意味着它的属性不能改变；
- `StatefulWidget` 持有的状态可能会在 widget 生命周期中发生变化。

要实现一个**状态部件**，至少需要两个类：`StatefulWidget` 和 `State`。

> 注意：`StatefulWidget` 类本身是不变的，但是 `State` 类在 widget 生命周期中始终存在。

1. 在 `main.dart` 末尾新建 `RandomWordsState`，代码如下：

   ```dart
   class RandomWordsState extends State {
     @override
     Widget build(BuildContext context) {
       return new Text(WordPair.random().asPascalCase);
     }
   }
   ```

2. 在 `main.dart` 末尾新建 `RandomWords`，代码如下：

   ```dart
   class RandomWords extends StatefulWidget {
     @override
     RandomWordsState createState() => new RandomWordsState();
   }
   ```

3. 修改 `main.dart` 的 `MyApp` 中 `body` 如下：

   ```dart
   body: new Center(
     child: new RandomWords(),
   ),
   ```

> 代码套路

1. 定义类继承自 `State`，重写 `build` 方法返回一个可变的 widget；
2. 定义类继承自 `StatefulWidget`，重写 `createState` 方法返回状态部件；
3. 在 `StatelessWidget` 部件中直接使用 `StatefulWidget`。

## 五. 无限滚动的 ListView

> ListView 的 builder 工厂构造函数允许您按需建立一个懒加载的列表视图。

### 5.1 添加 ListView

1. 在 `RandomWordsState` 添加一个私有方法 `_buildSuggestions` 并实现以下代码：

   ```dart
   Widget _buildSuggestions() {
     return new ListView.builder(itemBuilder: (BuildContext _context, int i) {
       print('Item Builder $i');

       return new ListTile(title: new Text(i.toString()));
     });
   }
   ```

2. 修改 `RandomWordsState` 的 `build` 方法如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     return new Scaffold(
       body: _buildSuggestions(),
     );
   }
   ```

> 运行程序，滚动列表窗口能够在**调试控制台**可以看到 ListView 的索引输出。

### 5.2 添加分隔线

1. 修改 `RandomWordsState` 的 `_buildSuggestions` 方法，如果是奇数行返回分隔线，代码如下：

   ```dart
   // 奇数行返回分割线
   if (i.isOdd) {
     return new Divider();
   }
   ```

2. 使用 `~/` 计算索引 i 除以 2 的商，代码如下：

   ```dart
   final idx = i ~/ 2; // ~/ 表示除以 2 的商
   print('Item Builder $idx');

   return new ListTile(title: new Text(idx.toString()));
   ```

3. 增加列表内容的缩进，代码如下：

   ```dart
   padding: EdgeInsets.all(16.0)
   ```

### 5.3 生成并显示单词对

1. 在 `RandomWordsState` 中定义 `_suggestions` 私有成员用于保存单词对数据，代码如下：

   ```dart
   final _suggestions = <WordPair>[];
   ```

2. 修改 `_buildSuggestions` 方法，根据 `idx` 生成并缓存单词对，代码如下：

   ```dart
   final idx = i ~/ 2; // ~/ 表示除以 2 的商

   // 缓冲 10 个单词对
   if (idx >= _suggestions.length) {
     _suggestions.addAll(generateWordPairs().take(10));
   }
   ```

3. 修改 `_buildSuggestions` 方法，返回单词对内容，代码如下：

   ```dart
   print('Item Builder $idx - ' + _suggestions[idx].asPascalCase);
   return new ListTile(title: new Text(_suggestions[idx].asPascalCase));
   ```

### 5.4 列表字体样式

1. 在 `RandomWordsState` 中定义 `_listTitleStyle` 私有成员用于保存列表字体样式，代码如下：

   ```dart
   final _listTitleStyle = const TextStyle(fontSize: 20);
   ```

2. 在 `RandomWordsState` 添加一个私有方法 `_buildRow` 并实现以下代码：

   ```dart
   Widget _buildRow(WordPair pair) =>
       new ListTile(title: new Text(pair.asPascalCase, style: _listTitleStyle));
   ```

3. 修改 `_buildSuggestions` 的返回 widget 代码如下：

   ```dart
   return _buildRow(_suggestions[idx]);
   ```

## 六. 收藏单词对

### 6.1 增加列表行尾部图标

1. 修改 `_buildRow` 方法，在列表尾部添加图标，代码如下：

   ```dart
   Widget _buildRow(WordPair pair) {
     return new ListTile(
       title: new Text(pair.asPascalCase, style: _listTitleStyle),
       trailing: new Icon(
         Icons.favorite,
         color: Colors.red,
       ),
     );
   }
   ```

2. 在 `RandomWordsState` 使用集合记录用户收藏的单词，代码如下：

   ```dart
   final _saved = new Set<WordPair>();
   ```

   > 提示：Set 中不允许重复的值。

3. 在 `_buildRow` 中增加局部变量，判断参数 `pair` 是否已经被用户收藏，代码如下：

   ```dart
   final bool alreaySaved = _saved.contains(pair);
   ```

4. 修改 `_buildRow` 的 `trailing` 代码如下：

   ```dart
   trailing: new Icon(
     alreaySaved ? Icons.favorite : Icons.favorite_border,
     color: alreaySaved ? Colors.red : null,
   )
   ```

### 6.2 增加交互

- 修改 `_buildRow`，在 `trailing` 下放增加 `onTap` 事件监听，代码如下：

  ```dart
  onTap: () {
    setState(() {
      alreaySaved ? _saved.remove(pair) : _saved.add(pair);
    });
  },
  ```

## 七. 页面跳转

在 Flutter 中，页面间的跳转被称为路由 route，其中：

- 导航器管理应用程序的**路由栈**；
- 将路由推入（push）到路由栈中，会显示新路由的页面；
- 从路由栈弹出（pop）路由，会返回到前一个路由。

### 7.1 页面跳转实现

1. 修改 `MyApp` 的 `build` 方法，删除 `AppBar` 代码如下：

   ```dart
   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return new MaterialApp(home: new RandomWords());
     }
   }
   ```

2. 修改 `RandomWordsState` 的 `build` 方法，增加 `AppBar` 代码如下：

   ```dart
   @override
   Widget build(BuildContext context) {
     return new Scaffold(
       appBar: new AppBar(
         title: new Text('单词列表'),
         actions: <Widget>[
           new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
         ],
       ),
       body: _buildSuggestions(),
     );
   }
   ```

3. 在 `RandomWordsState` 添加一个私有方法 `_pushSaved` 并实现以下代码：

   ```dart
   void _pushSaved() {
     Navigator.of(context)
         .push(new MaterialPageRoute(builder: (BuildContext context) {
       return new Scaffold(
           appBar: new AppBar(
         title: new Text('收藏单词'),
       ));
     }));
   }
   ```

> 运行程序，点击导航栏右侧的列表按钮已经可以跳转到一个新的页面，并且能够实现页面间切换。

### 7.2 显示子路由数据

1. 修改 `_pushSaved` 方法，增加对 `_saved` 的数据处理，代码如下：

   ```dart
   final list = _saved.map((e) => new ListTile(
       title: new Text(e.asPascalCase, style: _listTitleStyle)));
   final children =
       ListTile.divideTiles(tiles: list, context: context).toList();
   ```

2. 修改 `_pushSaved` 方法的 `return` 增加 `body` 内容显示，代码如下：

   ```dart
   return new Scaffold(
     appBar: new AppBar(
       title: new Text('收藏单词'),
     ),
     body: new ListView(children: children, padding: EdgeInsets.all(16)),
   );
   ```

## 八. 使用 Themes

- 修改 `MyApp` 的 `build` 方法，增加 `Themes` 代码如下：

  ```dart
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
          theme: new ThemeData(primaryColor: Colors.green),
          home: new RandomWords());
    }
  }
  ```

## 九. 总结

通过本案例习得以下知识点：

1. Flutter 中大多数东西都是 widget；
2. `StatelessWidget` 和 `StatefulWidget`，页面布局的基本套路；
3. `ListView` 懒加载列表视图；
4. 简单的交互实现；
5. 通过状态更新视图；
6. 通过 `Navigator` 路由栈实现导航跳转。

> 心得：有 ES6+ 和 React 基础上手 Flutter 会很容易，学习新技术通过官网示例是最佳途径。
