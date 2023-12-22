import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/customFloatingButton.dart';
import '../utils/customFooter.dart';
import '../utils/customHeader.dart';
import 'add_feed.dart';
import 'feed_model.dart';
import 'feed_provider.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({Key? key});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex; // Define _currentIndex here

  final List<String> _tabs = ['Feeds', 'Drafts'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _currentIndex = 0; // Initialize _currentIndex

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _tabController.index = index; // Update tab controller index
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFeedPage()),
          );
        },
        svgIconPath: 'assets/cplus.svg',
        buttonColor: Colors.red,
      ),
      body: _buildFeedList(context), // Display the feed list
    );
  }

  Widget _buildFeedList(BuildContext context) {
    return CustomScrollView(
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
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(
            TabBar(
              controller: _tabController,
              tabs: _tabs.map((String tab) {
                return Tab(text: tab);
              }).toList(),
            ),
          ),
          pinned: true,
        ),
        _buildFeedContent(context), // Display feed content
      ],
    );
  }

  Widget _buildFeedContent(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);
    final feeds = feedProvider.feeds;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final feed = feeds[index];
          return Column(
            children: [
              ListTile(
                title: Text(feed.text),
              ),
              if (feed.imageFile != null) Image.file(feed.imageFile!),
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
              const Divider(),
            ],
          );
        },
        childCount: feeds.length,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
