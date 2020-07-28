# 安装 Flutter SDK & IDE

1. 访问 [Flutter 中文网](https://flutter.cn/docs/get-started/install/) 下载 Flutter SDK，解压缩到 `~/dev/flutter-sdk/flutter/`

2. 访问 [Dart 中文网](https://dart.cn/get-dart) 下载 Dart SDK，解压缩到 `~/dev/flutter-sdk/dart-sdk/`

3. 修改 `~/.zshrc` 增加以下内容：

   ```ini
   # flutter 请参阅 https://flutter.cn/community/china
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

   export PATH="$PATH:$HOME/dev/flutter-sdk/flutter/bin:$HOME/dev/flutter-sdk/dart-sdk/bin"
   ```

4. 安装 IDE

   1. [Android Studio](https://developer.android.com/studio/)(Flutter and Dart Plugin)
   2. Xcode (cocoapods)
   3. [VSCode](https://code.visualstudio.com/)(Flutter and Dart Plugin)

5. 检查 Flutter 开发环境

   ```bash
   flutter doctor
   ```
