# Flutter Samples

## 安装 Flutter SDK

- [安装 Flutter SDK & IDE](./docs/install-flutter-sdk.md)

## 移动开发学习路线图

1. 界面布局
2. 界面跳转
3. 用户交互
4. 图片素材
5. 动画
6. 网络请求和异步
7. 数据和业务模型 <https://book.flutterchina.club/chapter11/json_model.html>
8. 屏幕适配
9. 组件和插件开发
10. 底层原理

## 案例列表

1. [第一个 Flutter App](./docs/001-first-flutter-app.md)
2. [构建 iOS 风格的应用](./docs/002-cupertino-app.md)
3. [Material 组件基础](./docs/003-mateial.md)
4. [实战：Github 客户端](./docs/004-github.md)

## 常见问题

- Q1：Flutter 中有没有像 Java 开发中的 Gson/Jackson 一样的 Json 序列化类库。
  - A1：没有，因为这样的库需要使用**运行时反射**，这在 Flutter 中是禁用的；
    - 运行时反射会干扰 Dart 的 tree shaking，使用 tree shaking，可以在 release 版中“去除”未使用的代码，这可以显著优化应用程序的大小。
    - 由于反射会默认应用到所有代码，因此 tree shaking 会很难工作，因为在启用反射时很难知道哪些代码未被使用，因此冗余代码很难剥离，所以 Flutter 中禁用了 Dart 的反射功能，而正因如此也就无法实现动态转化 Model 的功能。
