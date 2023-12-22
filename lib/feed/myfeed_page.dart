import 'dart:io';
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

class _MyFeedPageState extends State<MyFeedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex; // Define _currentIndex here

  final List<String> _tabs = ['Feeds', 'Drafts'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _currentIndex = 0; // Initialize _currentIndex
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: _tabs.map((String tab) {
              return Tab(text: tab);
            }).toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update _currentIndex on tab selection
              });
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Your Feeds content goes here
                _buildFeedList(context), // Replace this with your feed content
                // Your Drafts content goes here
                _buildDraftList(context), // Replace this with your draft content
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
          if (_currentIndex == 0) {
            PostCache? newPostCache = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddFeedPage()),
            );

            if (newPostCache != null) {
              Provider.of<FeedModel>(context, listen: false).addPostCache(newPostCache);
            }
          } else {
            // Handle adding draft functionality here
          }
        },
        svgIconPath: 'assets/cplus.svg',
        buttonColor: Colors.red,
      ),
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final feedProvider = Provider.of<FeedProvider>(context);
              final postCaches = feedProvider.postCaches;
              final postCache = postCaches[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(postCache.textContent),
                  ),
                  if (postCache.mediaPath != null) Image.file(File(postCache.mediaPath!)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // Toggle the like status immediately
                          await Provider.of<FeedModel>(context, listen: false)
                              .toggleLike(postCache);
                        },
                        icon: Icon(
                          postCache.likeCount == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: postCache.likeCount == 1 ? Colors.red : null,
                        ),
                      ),
                      Text(postCache.likeCount == 1 ? '1' : '0'),
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
                        onPressed: () {
                          // Handle custom action 2 functionality here
                        },
                        icon: Icon(Icons.star_outline_sharp),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
            childCount: Provider.of<FeedProvider>(context).postCaches.length,
          ),
        ),
      ],
    );
  }

  Widget _buildDraftList(BuildContext context) {
    // Build your draft list UI here similar to the feed list
    return Container(
      child: Center(
        child: Text("Drafts Content"),
      ),
    );
  }
}