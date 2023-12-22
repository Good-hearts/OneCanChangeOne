import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goodhearts/database/database_helper.dart';

import 'feed_model.dart';
import 'feed_provider.dart';

class CommentBottomSheet extends StatefulWidget {
  final PostCache postCache;

  CommentBottomSheet({required this.postCache});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.postCache.comments.length,
            itemBuilder: (context, index) {
              Comment comment = widget.postCache.comments[index];
              return ListTile(
                title: Text(comment.textContent),
                // Customize the comment display as needed
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _addComment(context, widget.postCache.postId, _commentController.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addComment(BuildContext context, int postId, String text) async {
    // Add the comment to the database
    Comment newComment = Comment(
      postId: postId,
      userId: 1, // Replace with the actual user ID
      textContent: text,
      time: DateTime.now().toIso8601String(), // Replace with the actual time
    );
    await DatabaseHelper.instance.insertComment(newComment);

    // Update the UI with the new comment
    Provider.of<FeedProvider>(context, listen: false).addCommentToPost(newComment);

    // Load comments for the specific post
    //await Provider.of<FeedProvider>(context, listen: false).loadCommentsForPost(postId);

    // Clear the comment input field
    _commentController.clear();
  }
}