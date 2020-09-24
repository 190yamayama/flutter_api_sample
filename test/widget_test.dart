// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/WidgetKey.dart';
import 'package:flutter_api_sample/ui/screen/HomeScreen.dart';
import 'package:flutter_api_sample/ui/screen/SplashScreen.dart';
import 'package:flutter_test/flutter_test.dart';

// テストコマンド
// flutter test test/widget_test.dart
void main() {

  // widgetのテストについて公式リファレンス
  // https://flutter.dev/docs/cookbook/testing/widget/introduction

  group('Splash Screen Test', () {

    testWidgets('Start Screen', (WidgetTester tester) async {

      // runAsyncでテストしないと「タイマーが残ってる」というエラーがでる…
      // WidgetTestの中では、タイマーは基本的にフェイクで、進んでいないそうです。
      // それで、Widgetツリーのタイマーは発火されずに残ってしまう、ということのよう
      // で、runAsyncで実行するとタイマーを進めることができる。ということらしい。
      await tester.runAsync(() async {

        // テスト対象画面呼び出し
        await tester.pumpWidget(
          MaterialApp(
            title: 'Flutter Test',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          ),
        );

        // スプラッシュ画像が表示されているか？
        final splashImage = find.byKey(Key(WidgetKey.KEY_SPLASH_SPLASH_IMAGE));
        expect(splashImage, findsOneWidget);

      });

    });

  });


  group('Home screen test', () {

    testWidgets('Start Screen', (WidgetTester tester) async {

      // runAsyncでテストしないとタイマーが残ってるというエラーがでる…
      // WidgetTestの中では、タイマーは基本的にフェイクで、進んでいないそうです。
      // それで、Widgetツリーのタイマーは発火されずに残ってしまう、ということのよう
      // で、runAsyncで実行するとタイマーを進めることができる。ということらしい。
      await tester.runAsync(() async {

        // テスト対象画面呼び出し
        await tester.pumpWidget(
          MaterialApp(
            title: 'Flutter Test',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
          ),
        );

        // タイトルが表示されているか？
        final title = find.byKey(Key(WidgetKey.KEY_HOME_APP_BAR_TITLE));
        expect(title, findsOneWidget);

        // 検索アイコンが表示されているか？
        final searchIcon = find.byKey(Key(WidgetKey.KEY_HOME_APP_BAR_ICON));
        expect(searchIcon, findsOneWidget);

        // 検索ボタンが表示されているか？
        final searchButton = find.byKey(Key(WidgetKey.KEY_HOME_APP_BAR_ICON_BUTTON));
        expect(searchButton, findsOneWidget);

        // リストビューが表示されているか？
        final listView = find.byKey(Key(WidgetKey.KEY_HOME_LIST_VIEW));
        expect(listView, findsOneWidget);

        // 検索実行
        await tester.tap(searchButton);


      });

    });

  });


}
