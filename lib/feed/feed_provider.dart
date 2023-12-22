import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'feed_model.dart';

class FeedProvider extends ChangeNotifier {
  List<PostCache> _postCaches = [];
  List<PostCache> get postCaches => List.from(_postCaches.reversed);

  Future<void> loadPostCachesFromDatabase() async {
    _postCaches = await DatabaseHelper.instance.getAllPostCaches();
    notifyListeners();
  }

  Future<void> addPostCacheToDatabase(PostCache postCache) async {
    await DatabaseHelper.instance.insertPostCache(postCache);
    await loadPostCachesFromDatabase();
  }

  Future<void> loadCommentsForPost(int postId) async {
    List<Comment> comments = await DatabaseHelper.instance.getCommentsForPost(postId);
    // Find the corresponding post in _postCaches and update its comments
    int postIndex = _postCaches.indexWhere((post) => post.postId == postId);
    if (postIndex != -1) {
      _postCaches[postIndex].comments = comments;
      notifyListeners();
    }
  }

  Future<void> addCommentToPost(Comment comment) async {
    await DatabaseHelper.instance.insertComment(comment);
    // Update the corresponding post with the new comment
    int postIndex = _postCaches.indexWhere((post) => post.postId == comment.postId);
    if (postIndex != -1) {
      _postCaches[postIndex].comments.add(comment);
      notifyListeners();
    }
  }


  Future<void> deletePostCache(PostCache postCache) async {
    await DatabaseHelper.instance.deletePostCache(postCache);
    _postCaches.remove(postCache);
    notifyListeners();
  }
}
