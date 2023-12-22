import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goodhearts/database/database_helper.dart';

class Feed {
  String text;
  File? imageFile;
  File? videoFile;
  double? imageHeight;
  double? imageWidth;
  bool isLiked;
  int? id;
  bool isDraft;

  Feed({
    required this.text,
    this.imageFile,
    this.videoFile,
    this.imageHeight,
    this.imageWidth,
    this.isLiked = false,
    this.id,
    this.isDraft = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageFilePath': imageFile?.path,
      'videoFilePath': videoFile?.path,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
      'isLiked': isLiked ? 1 : 0,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      text: map['text'],
      imageFile:
          map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
      videoFile:
          map['videoFilePath'] != null ? File(map['videoFilePath']) : null,
      imageHeight: map['imageHeight'],
      imageWidth: map['imageWidth'],
      isLiked: map['isLiked'] == 1,
      id: map['id'],
    );
  }
}

class FeedModel extends ChangeNotifier {
  final _currentIndex = 0;
  final List<Feed> _feeds = [];

  int get currentIndex => _currentIndex;
  List<Feed> get feeds => _feeds;

  void addFeed(Feed newFeed) {
    _feeds.add(newFeed);
    notifyListeners();
  }

  Future<void> toggleLike(Feed feed) async {
    feed.isLiked = !feed.isLiked;
    await DatabaseHelper.instance.updateLikeStatus(feed);
    notifyListeners();
  }
}
