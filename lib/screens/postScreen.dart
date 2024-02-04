import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:black_coffer/constants/image_picker_screen.dart';
import 'package:video_player/video_player.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // File? selectedImage;
  // String base64Image = "";
  // Uint8List? _file;
  // bool isLoading = false;
  String? _videoURL;
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Future<void> chooseVideo(type) async {
  //   // ignore: prefer_typing_uninitialized_variables
  //   var image;
  //   if (type == "camera") {
  //     image = await ImagePicker().pickVideo(source: ImageSource.camera);
  //   } else {
  //     image = await ImagePicker().pickVideo(source: ImageSource.gallery);
  //   }
  //   if (image != null) {
  //     setState(
  //       () {
  //         selectedImage = File(image.path);
  //         base64Image = base64Encode(selectedImage!.readAsBytesSync());
  //       },
  //     );
  //   }
  // }

  // pickImage(ImageSource source) async {
  //   final ImagePicker imagePicker = ImagePicker();
  //   XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery);
  //   if (file != null) {
  //     return await file.readAsBytes();
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add post',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
        ),
      ),
      body: Center(
        child: _videoURL != null
            ? _videoPreviewWidget()
            : GestureDetector(
                onTap: () {
                  _showOptionsDialog(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 350,
                      child: Center(
                        child: Lottie.asset(
                          'assets/animations/an.json',
                          width: 350,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Added SizedBox for spacing
                    const Text(
                      'Tap on animation to upload',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    print("Options dialog called"); // Add this line for debugging

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    print("Upload from Gallery tapped");
                    _pickVideo();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Upload from Gallery'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    print("Record a Video tapped");
                  },
                  child: const ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Record a Video'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: VideoPlayer(_controller!),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
