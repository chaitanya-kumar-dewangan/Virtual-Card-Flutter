import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool ScanOver = false;
  List<String> lines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: const Text('Capture'),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_album),
                label: const Text('Gallery'),
              ),
            ],
          ),
          Wrap(
            children: lines.map((line) => LineItem(line: line)).toList(),
          )
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(
      source: camera,
    );
    if (xFile != null) {
      EasyLoading.show(status: 'Please Wait');
      print(xFile.path);
      final textRoconizer = TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRoconizer
          .processImage(InputImage.fromFile(File(xFile.path)));
      EasyLoading.dismiss();
      final templist = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          templist.add(line.text);
        }
      }
      setState(() {
        lines = templist;
        ScanOver = true;
      });
      print(templist);
    }
  }
}

class LineItem extends StatelessWidget {
  final String line;

  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        data: line,
        dragAnchorStrategy: childDragAnchorStrategy,
        feedback: Container(
          key: GlobalKey(),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.black45),
          child: Text(
            line,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ),
    child: Chip(
      label: Text(line),
    ),);
  }
}
