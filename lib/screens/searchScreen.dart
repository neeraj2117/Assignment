import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Search Videos',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
        ),
      ),
      body: const Center(
        child: Text(
          'Search',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
        ),
      ),
    );
  }
}
