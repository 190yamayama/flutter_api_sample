// ！！注意！！
// testファイルにmaterial.dartをimportすることはできません！！
// material.dartがインポートされているファイルもimportできません。
// つまり、画面のdartファイルはimport不可能です。
// 参考）https://github.com/flutter/flutter/issues/56192
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_api_sample/main.dart' as app;

void main() {
  // 拡張機能を有効化
  enableFlutterDriverExtension();

  // メイン画面起動
  app.main();
}
