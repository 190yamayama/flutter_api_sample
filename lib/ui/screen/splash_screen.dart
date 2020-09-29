import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/widget_keys.dart';
import 'package:flutter_api_sample/viewModel/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final viewModel = SplashScreenViewModel();

  @override
  Widget build(BuildContext context) {

    // タイマーでの画面遷移
    viewModel.moveNextScreen(context);

    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: SplashScreenPage()
    );
  }

}

class SplashScreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image(
              key: Key(WidgetKey.KEY_SPLASH_SPLASH_IMAGE),
              image: AssetImage('assets/splash.png')
          ),
      ),
    );
  }
}