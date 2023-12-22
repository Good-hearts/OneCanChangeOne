import 'package:flutter/material.dart';
import 'package:goodhearts/activites/share_page.dart';
import 'package:goodhearts/feed/feed_page.dart';
import 'package:goodhearts/utils/colors.dart';
import 'package:provider/provider.dart';
import '../utils/customFloatingButton.dart';
import '../utils/customFooter.dart';
import 'Comment_page.dart';
import '../feed/add_feed.dart';
import 'package:goodhearts/utils/customHeader.dart';
import 'package:goodhearts/feed/feed_model.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  var _currentIndex = 0;
  List<PostCache> postCaches = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomHeader(
        title: 'Like',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 40), backgroundColor: buttons,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(46, 40),
                    side: BorderSide(color: appColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Most Liked',
                    style: TextStyle(
                      color: appColor,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 40), backgroundColor: buttons,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Top commented',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SharePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 40), backgroundColor: buttons,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Max Shared',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most Liked',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.09),
                    ), backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Insights',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingButton(
        onPressed: () async {
      PostCache? newPostCache = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFeedPage()),
      );

      if (newPostCache != null) {
      Provider.of<FeedModel>(context, listen: false).addPostCache(newPostCache);
      setState(() {
      _currentIndex = 0;
      });
      }
      },
        svgIconPath: 'assets/cplus.svg',
        buttonColor: Colors.red,
      ),
    );
  }
}
