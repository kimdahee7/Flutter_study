import 'package:flutter/material.dart';
import 'package:prac_flutter/tabbar_mycustomform_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car, color: Colors.blue)),
              Tab(icon: Icon(Icons.directions_transit, color: Colors.blue)),
              Tab(icon: Icon(Icons.directions_bike, color: Colors.blue)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            MyCustomForm(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
