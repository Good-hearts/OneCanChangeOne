import 'package:flutter/material.dart';
import 'package:goodhearts/utils/colors.dart';
import '../feed/feed_page.dart';

class CustomFooter extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomFooter({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        border: Border.all(
          color: border,
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: footer,
          currentIndex: widget.currentIndex,
          selectedItemColor: appColor,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            widget.onTap(index);
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedPage()),
                );
                break;
              case 1:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LocationFeedPage()),
                // );
                break;
              default:
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Location Feed',
            ),
          ],
        ),
      ),
    );
  }
}
