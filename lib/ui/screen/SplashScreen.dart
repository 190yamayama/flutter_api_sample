import 'package:flutter/material.dart';
import 'package:flutter_api_sample/viewModel/SplashScreenViewModel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  static const String KEY_SPLASH_IMAGE = "splash_image";

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
              key: Key(SplashScreen.KEY_SPLASH_IMAGE),
              image: AssetImage('assets/splash.png')
          ),
      ),
    );
  }
}