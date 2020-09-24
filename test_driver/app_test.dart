// ！！注意！！
// testファイルにmaterial.dartをimportすることはできません！！
// material.dartがインポートされているファイルもimportできません。
// つまり、画面のdartファイルはimport不可能です。
// 参考）https://github.com/flutter/flutter/issues/56192
import 'package:flutter_api_sample/ui/WidgetKey.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// テストコマンド
// flutter drive --target=test_driver/app.dart
//
// 参考）https://medium.com/ionicfirebaseapp/an-introduction-to-integration-testing-for-flutter-app-b7d2b2af1739
void main() {

  group('Qiita App', () {

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null)
        driver.close();
    });

    test('check flutter driver extension', () async {
      final health = await driver.checkHealth();
      print(health.status);
    });

    test('test show splash screen', () async {
      SerializableFinder image = find.byValueKey(WidgetKey.KEY_SPLASH_SPLASH_IMAGE);
      await driver.waitFor(image, timeout: const Duration(seconds: 3));
    });

    test('test pull refresh pattern', () async {

      // pull refresh
      final listView = find.byValueKey(WidgetKey.KEY_HOME_LIST_VIEW);
      await driver.scroll(listView, 0, 300.0, Duration(milliseconds: 500));

      // 記事詳細を開く
      final title = find.byValueKey(WidgetKey.KEY_HOME_LIST_VIEW_ROW_TITLE + "_0");
      await driver.tap(title);

      // コールバックがキューからなくなるまでまつ
      await driver.waitUntilNoTransientCallbacks();

      final back = find.byValueKey(WidgetKey.KEY_WEB_APP_BAR_ICON_BUTTON);
      final webView = find.byValueKey(WidgetKey.KEY_WEB_WEB_VIEW);
      await driver.scrollUntilVisible(webView, back, dyScroll: -50.0);

      // 戻る
      await driver.tap(back);
    }, timeout: Timeout(Duration(seconds: 40))); // こんな感じでタイムアウトの秒数を変更できる

    test('test search button pattern', () async {

      final searchButton = find.byValueKey(WidgetKey.KEY_HOME_APP_BAR_ICON_BUTTON);
      final listView = find.byValueKey(WidgetKey.KEY_HOME_LIST_VIEW);

      // 検索実行
      await driver.tap(searchButton);

      // 20行目まで（追加読み込みが発生するまで）スクロール
      final title = find.byValueKey(WidgetKey.KEY_HOME_LIST_VIEW_ROW_TITLE + "_20");
      await driver.scrollUntilVisible(listView, title, dyScroll: -500.0);

      // 記事詳細を開く
      await driver.tap(title);

      // レンダリングが終わるまでまつ
      await driver.waitUntilFirstFrameRasterized();

      final back = find.byValueKey(WidgetKey.KEY_WEB_APP_BAR_ICON_BUTTON);
      final webView = find.byValueKey(WidgetKey.KEY_WEB_WEB_VIEW);
      await driver.scrollUntilVisible(webView, back, dyScroll: -50.0);

      // 戻る　
      await driver.tap(back);
    }, timeout: Timeout(Duration(seconds: 50))); // こんな感じでタイムアウトの秒数を変更できる


  });

}