# 实战：Github 客户端

> 参考文章：[Github 客户端示例](https://book.flutterchina.club/chapter15/intro.html)。

## 一. 项目概述

### 1.1 业务功能

1. 实现 Github 账号登录、退出登录功能
2. 登录后可以查看自己的项目主页
3. 支持换肤
4. 支持多语言
5. 登录状态可以持久化

### 1.2 技术方案

1. 网络请求，请求 Github API；
2. JSON 转 Dart Model 类；
3. 全局状态管理，语言、主题、登录态等全局共享；
4. 持久化存储，保存登录信息，用户信息等；
5. 支持国际化、Intl 包的使用。

## 二. 搭建初始 App

### 2.1 新建项目

在 VSCode 中按 `cmd + shift + p`，输入并选择 `Flutter: New Project`

1. 输入 `sample_04_github`，然后选择保存项目的目录；
2. 删除 `/test` 目录；
3. 修改 `/lib/main.dart` 内容如下：

   ```dart
   import 'package:flutter/material.dart';

   void main() {
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) => Container(color: Colors.blue);
   }
   ```

4. 新建 `assets` 目录并建立如下子目录：

   ```ini
   assets              # 素材目录
   ├── fonts           # 字体
   ├── images          # 图像
   ├── jsons           # JSON 文件
   └── l10n-arb        # 国际化
   ```

5. 在 `lib` 目录下新建如下子目录：

   ```ini
   lib
   ├── common          # 工具类
   ├── l10n            # 国际化相关类
   ├── models          # Model 类
   ├── routes          # 路由页面类
   ├── states          # 跨组件共享的状态类
   └── widgets         # 组件
   ```
