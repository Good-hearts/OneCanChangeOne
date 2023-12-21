import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodhearts/activites/Comment_page.dart';
import 'package:goodhearts/activites/like_page.dart';
import 'package:goodhearts/activites/share_page.dart';
import 'package:goodhearts/utils/colors.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import 'feed_provider.dart';
import '../utils/customFloatingButton.dart';
import '../utils/customFooter.dart';
import 'add_feed.dart';
import 'package:goodhearts/utils/customHeader.dart';
import 'feed_model.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var _currentIndex = 0;
  bool showFullText = false;

  Future<void> _deleteFeedConfirmation(BuildContext context, Feed feed) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Post'),
          content: Text('Are you sure you want to remove this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteFeed(feed);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteFeed(Feed feed) async {
    // Remove from UI
    setState(() {
      Provider.of<FeedProvider>(context, listen: false).deleteFeed(feed);
    });

    // Remove from database
    await DatabaseHelper.instance.deleteFeed(feed);
  }

  Widget _buildPostWidget(Feed feed) {
    final int maxDisplayWords = 10;

    String getLimitedText(String text) {
      if (showFullText) {
        return text;
      }

      List<String> words = text.split(' ');
      if (words.length > maxDisplayWords) {
        return words.take(maxDisplayWords).join(' ') + '... Show More';
      } else {
        return text;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: SvgPicture.asset('assets/logo.svg'),
              ),
              const SizedBox(width: 8),
              const Text(
                'Good Hearts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (String choice) {
                  if (choice == 'Delete') {
                    _deleteFeedConfirmation(context, feed);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return ['Delete'].map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            choice,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
        // Post content
        if (feed.text.isNotEmpty)
          ListTile(
            title: GestureDetector(
              onTap: () {
                setState(() {
                  showFullText = !showFullText;
                });
              },
              child: Text(getLimitedText(feed.text)),
            ),
          ),
        if (feed.text.isEmpty)
          SizedBox(
            height: 10,
          ),
        if (feed.imageFile != null) Image.file(feed.imageFile!),
        if (feed.videoFile != null)
          VideoPlayerWidget(videoFile: feed.videoFile!),
        Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    // Toggle the like status immediately
                    await Provider.of<FeedModel>(context, listen: false)
                        .toggleLike(feed);
                  },
                  icon: Icon(
                    feed.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: feed.isLiked ? Colors.red : null,
                  ),
                ),
                Text(feed.isLiked ? '1' : '0'),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.message_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.repeat_one_sharp),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.star_outline_sharp),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<FeedProvider>(context, listen: false).loadFeedsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            flexibleSpace: CustomHeader(
              title: 'Your Title',
              showBackButton: false,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
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
                      'All',
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
                        MaterialPageRoute(
                            builder: (context) => const LikePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      backgroundColor: buttons,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Most Liked',
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
                        MaterialPageRoute(
                            builder: (context) => const CommentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      backgroundColor: buttons,
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
                        MaterialPageRoute(
                            builder: (context) => const SharePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      backgroundColor: buttons,
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All',
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
                      ),
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Insights',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display Feeds
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var feedProvider = Provider.of<FeedProvider>(context);
                var feeds = feedProvider.feeds;
                var feed = feeds[index];
                return Column(
                  children: [
                    _buildPostWidget(feed),
                    const Divider(),
                  ],
                );
              },
              childCount: Provider.of<FeedProvider>(context).feeds.length,
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
          Feed? newFeed = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFeedPage()),
          );

          if (newFeed != null) {
            Provider.of<FeedModel>(context, listen: false).addFeed(newFeed);
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
