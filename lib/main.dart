import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter api Sample',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SplashScreen()
    );
  }

}