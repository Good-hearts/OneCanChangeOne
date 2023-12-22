import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goodhearts/database/database_helper.dart';

class User {
  int? id;
  String username;
  String? profilePicturePath;
  String? settings;

  User({
    this.id,
    required this.username,
    this.profilePicturePath,
    this.settings,
  });
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profilePicturePath': profilePicturePath,
      'settings': settings,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      profilePicturePath: map['profilePicturePath'],
      settings: map['settings'],
    );
  }
}

class PostCache {
  int? id;
  int postId;
  String textContent;
  String? mediaPath;
  String time;
  int likeCount;
  int commentCount;
  List<Comment> comments;

  PostCache({
    this.id,
    required this.postId,
    required this.textContent,
    this.mediaPath,
    required this.time,
    this.likeCount = 0,
    this.commentCount = 0,
    this.comments = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'textContent': textContent,
      'mediaPath': mediaPath,
      'time': time,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'comments': comments.map((comment) => comment.toMap()).toList(),

    };
  }

  factory PostCache.fromMap(Map<String, dynamic> map) {
    return PostCache(
      id: map['id'],
      postId: map['postId'],
      textContent: map['textContent'],
      mediaPath: map['mediaPath'],
      time: map['time'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      comments: List<Comment>.from(
          map['comments']?.map((x) => Comment.fromMap(x)) ?? const []),
    );
  }
}


class Comment {
  int? id;
  int postId;
  int userId;
  String textContent;
  String time;

  Comment({
    this.id,
    required this.postId,
    required this.userId,
    required this.textContent,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'textContent': textContent,
      'time': time,
    };
  }
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
      textContent: map['textContent'],
      time: map['time'],
    );
  }
}

class FeedModel extends ChangeNotifier {
  final _currentIndex = 0;
  final List<PostCache> _postCaches = [];

  int get currentIndex => _currentIndex;
  List<PostCache> get postCaches => _postCaches;

  void addPostCache(PostCache newPostCache) {
    _postCaches.add(newPostCache);
    notifyListeners();
  }

  Future<void> toggleLike(PostCache postCache) async {
    postCache.likeCount = postCache.likeCount == 1 ? 0 : 1;
    await DatabaseHelper.instance.updatePostCacheLikeStatus(postCache);
    notifyListeners();
  }
}
