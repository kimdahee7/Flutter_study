import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  //default 값을 정의, FloatingButton을 누를 때 이 속성을 업데이트한다.
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animation2"),
      ),
      body: Center(
        child: AnimatedContainer(
          //State 클래스에 저장된 속성들을 사용한다.
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          //애니메이션이 지속되는 시간을 정의한다.
          duration: const Duration(seconds: 1),
          //애니메이션을 자연스럽게 하기 위해 곡선을 선택적으로 제공한다.
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        //FloatingButton을 누를 때,
        onPressed: () {
          //setState를 사용하여 위젯을 새 값으로 rebuild
          setState(() {
            //값을 랜덤으로 생성
            final random = Random();
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            _color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );

            _borderRadius =
                BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}
