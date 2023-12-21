import 'package:flutter/material.dart';

class Recommendation_Page extends StatefulWidget {
  const Recommendation_Page({super.key});

  @override
  State<Recommendation_Page> createState() => _Recommendation_PageState();
}

class _Recommendation_PageState extends State<Recommendation_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Recommendations',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: const [
          Divider(
            height: 1,
            thickness: 0.8,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
