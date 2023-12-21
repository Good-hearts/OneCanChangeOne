import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconFont extends StatefulWidget {
  const IconFont({super.key});

  @override
  _IconFontState createState() => _IconFontState();
}

class _IconFontState extends State<IconFont>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ScaleTransition(
          scale: _animation,
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 70,
            height: 68,
          ),
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  final int duration;
  final Widget goToPage;

  const SplashPage({super.key, required this.goToPage, required this.duration});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: widget.duration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.goToPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const IconFont();
  }
}
