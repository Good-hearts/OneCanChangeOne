import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goodhearts/feed/feed_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'feed_provider.dart';
import 'feed_model.dart';
import '../utils/customFloatingButton.dart';
import '../utils/customFooter.dart';
import 'package:video_player/video_player.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key});

  @override
  _AddFeedPageState createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  var _currentIndex = 0;
  final TextEditingController _textEditingController = TextEditingController();

  File? _imageFile;
  File? _videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Feed',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              postToFeed();
            },
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            color: Colors.grey,
            thickness: 0.7,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: 'What’s the good thing you did?',
                        border: InputBorder.none,
                      ),
                    ),
                    _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    _videoFile != null
                        ? VideoPlayerWidget(videoFile: _videoFile!)
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(),
              ListTile(
                leading: const Icon(Icons.camera_alt, size: 25.0),
                title: const Text('Attach Photo'),
                onTap: () async {
                  // Show a bottom sheet with options for Camera and Gallery
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('Take Photo'),
                              onTap: () async {
                                Navigator.pop(context);
                                _pickMedia(ImageSource.camera, (file) {
                                  setState(() {
                                    _imageFile = file;
                                  });
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () async {
                                Navigator.pop(context);
                                _pickMedia(ImageSource.gallery, (file) {
                                  setState(() {
                                    _imageFile = file;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.videocam, size: 25.0),
                title: const Text('Attach Video'),
                onTap: () async {
                  // Show a bottom sheet with options for Camera and Gallery
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.videocam),
                              title: const Text('Record Video'),
                              onTap: () async {
                                Navigator.pop(context);
                                _pickVideo(ImageSource.camera, (file) {
                                  setState(() {
                                    _videoFile = file;
                                  });
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.video_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () async {
                                Navigator.pop(context);
                                _pickVideo(ImageSource.gallery, (file) {
                                  setState(() {
                                    _videoFile = file;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
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
        onPressed: () {
          if (_currentIndex == 0) {
            // Handle image selection
            _pickMedia(ImageSource.gallery, (file) {
              setState(() {
                _imageFile = file;
                _videoFile = null;
              });
            });
          } else if (_currentIndex == 1) {
            // Handle video selection
            _pickVideo(ImageSource.gallery, (file) {
              setState(() {
                _videoFile = file;
                _imageFile = null;
              });
            });
          }
        },
        svgIconPath: 'assets/cplus.svg',
        buttonColor: Colors.red,
      ),
    );
  }

  void _pickMedia(ImageSource source, Function(File) setFile) async {
    final picker = ImagePicker();
    XFile? pickedMedia;

    if (source == ImageSource.camera) {
      pickedMedia = await picker.pickImage(
        source: source,
      );
    } else if (source == ImageSource.gallery) {
      pickedMedia = await picker.pickImage(source: source);
    }

    if (pickedMedia != null) {
      setFile(File(pickedMedia.path));
    }
  }

  void _pickVideo(ImageSource source, Function(File) setFile) async {
    final picker = ImagePicker();
    XFile? pickedMedia;

    if (source == ImageSource.camera) {
      pickedMedia = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 60), // Adjust as needed
      );
    } else if (source == ImageSource.gallery) {
      pickedMedia = await picker.pickVideo(source: source);
    }

    if (pickedMedia != null) {
      setFile(File(pickedMedia.path));
    }
  }

  @override
  Future<void> postToFeed() async {
    String text = _textEditingController.text.trim();

    if (_imageFile == null && _videoFile == null) {
      // Show an error message or handle the case where neither image nor video is selected
      return;
    }
    PostCache newPostCache = PostCache(
      postId: 0, // You might need to set a proper postId based on your logic
      textContent: text,
      mediaPath: _imageFile?.path ?? _videoFile?.path,
      time: DateTime.now().toString(),
    );

    // Use Provider to add the new feed
    await Provider.of<FeedProvider>(context, listen: false)
        .addPostCacheToDatabase(newPostCache);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const FeedPage()),
          (Route<dynamic> route) => false,
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({required this.videoFile, super.key});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });

    // Auto-play when the video becomes visible
    _controller.addListener(() {
      if (_isVisible && _controller.value.isPlaying) {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('video_visibility_key'),
      onVisibilityChanged: (visibilityInfo) {
        if (mounted) {
          setState(() {
            _isVisible = visibilityInfo.visibleFraction > 0.5;
          });

          if (_isVisible && !_controller.value.isPlaying) {
            _controller.play();
          } else if (!_isVisible && _controller.value.isPlaying) {
            _controller.pause();
          }
        }
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
