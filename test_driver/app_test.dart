import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/screen/HomeScreen.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// テストコマンド
// flutter drive --target=test_driver/app.dart
void main() {

  group('Qiita App', () {

    final searchButton = find.byValueKey(HomeScreen.KEY_APP_BAR_ICON_BUTTON);

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver extension', () async {
      final health = await driver.checkHealth();
      print(health.status);
    });

    test('search the article', () async {

      await driver.waitFor(searchButton, timeout: const Duration(seconds: 3));

      // // 実行
      // await driver.tap(searchButton);

    });

  });

}