// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class UploadForm extends StatefulWidget {
//   final File videoFile;
//   final String videoPath;

//   const UploadForm(
//       {super.key, required this.videoFile, required this.videoPath});

//   @override
//   State<UploadForm> createState() => _UploadFormState();
// }

// class _UploadFormState extends State<UploadForm> {
//   File? selectedImage;
//   String base64Image = "";

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

pickVideo() async {
  final picker = ImagePicker();
  XFile? videoFile;

  try {
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile!.path;
  } catch (e) {
    print('Error picking video: $e');
  }
}
