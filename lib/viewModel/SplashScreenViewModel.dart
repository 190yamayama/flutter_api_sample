import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/screen/HomeScreen.dart';


class SplashScreenViewModel with ChangeNotifier {

  SplashScreenViewModel();

  void moveNextScreen(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      // （backで戻れないように）置き換えて遷移する
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
      );
    });
  }

}
