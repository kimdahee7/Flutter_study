import 'package:flutter/material.dart';
import 'animation_screen.dart';
import 'animation_screen2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    //버튼 row2
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColum(color, Icons.call, 'CALL'),
        _buildButtonColum(color, Icons.near_me, 'ROUTE'),
        _buildButtonColum(color, Icons.share, 'SHARE'),
      ],
    );

    //텍스트
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter layout"),
        ),
        body: ListView(
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                'images/lake.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
                //가능한 작게 하지만 렌더 박스 전체를 덮을 정도로만 작아야 한다는 것
              ),
            ),
            _titleSection(),
            buttonSection,
            textSection,
            //페이지 route 전환 애니메이션 버튼
            ElevatedButton(
              child: const Text('Animation1'),
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
            ElevatedButton(
              child: const Text('Animation2'),
              onPressed: () {
                Navigator.of(context).push(_createRoute2());
              },
            ),
          ],
        ),
        //이미지 opacity를 변경하는 floating button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          },
          tooltip: 'Toggle Opacity',
          child: const Icon(Icons.flip),
        ));
  }
}

//타이틀 row
Widget _titleSection() {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const FavoriteWidget(),
      ],
    ),
  );
}

//버튼 row
//색,아이콘,텍스트를 인수로 받아 주어진 색으로 칠한 위젯을 반환하는 메소드
Column _buildButtonColum(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

//별모양 아이콘 누르기
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? const Icon(Icons.star) : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Text('$_favoriteCount'),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}

//Animation1 페이지 route 전환 애니메이션
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const AnimationScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      //Tween과 CurveTween chain()으로 결합
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

//Animation2 페이지 route 전환 애니메이션
Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const AnimatedContainerApp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      //Tween과 CurveTween chain()으로 결합
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
