import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'feed_model.dart';
import 'package:flutter/foundation.dart';

class FeedProvider extends ChangeNotifier {
  List<Feed> _feeds = [];
  List<Feed> _drafts = [];

  List<Feed> get feeds => List.from(_feeds.reversed);

  Future<void> loadFeedsFromDatabase() async {
    _feeds = await DatabaseHelper.instance.getAllFeeds();
    notifyListeners();
  }

  Future<void> addFeedToDatabase(Feed feed) async {
    await DatabaseHelper.instance.insertFeed(feed);
    await loadFeedsFromDatabase();
    // Reload the feeds after adding a new one
  }

  Future<void> deleteFeed(Feed feed) async {
    await DatabaseHelper.instance.deleteFeed(feed);
    _feeds.remove(feed);
    notifyListeners();
  }

  void addDraft(Feed draft) {
    _drafts.add(draft);
    notifyListeners();
  }

  List<Feed> get drafts => _drafts;
}
