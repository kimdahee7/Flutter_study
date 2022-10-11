import 'package:flutter/material.dart';
import 'package:prac_flutter/randomwords_screen.dart';

//첫 번째 앱 작성하기
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  //생성자
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      //App 테마 색상 흰색으로 변경하기
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
    );
  }
}