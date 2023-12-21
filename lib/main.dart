import 'package:flutter/material.dart';
import 'package:goodhearts/feed/feed_model.dart';
import 'package:goodhearts/splash_page.dart';
import 'package:goodhearts/authentication/login_page.dart';
import 'package:provider/provider.dart';
import 'feed/feed_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FeedProvider()),
        ChangeNotifierProvider(create: (context) => FeedModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Custom fonts",
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashPage(duration: 4, goToPage: LoginPage()),
    );
  }
}
