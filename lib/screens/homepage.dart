import 'package:black_coffer/screens/feedScreen.dart';
import 'package:black_coffer/screens/postScreen.dart';
import 'package:black_coffer/screens/profileScreen.dart';
import 'package:black_coffer/screens/searchScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade300,
        height: 75,
        animationDuration: const Duration(milliseconds: 300),
        index: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.man,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple,
      body: _getPage(_pageIndex),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: FeedScreen(),
        );
      case 1:
        return const Center(
          child: SearchScreen(),
        );
      case 2:
        return const Center(
          child: PostScreen(),
        );
      case 3:
        return const Center(
          child: ProfileScreen(),
        );
      default:
        return const Center(
          child: Text('Unknown Page'),
        );
    }
  }
}
