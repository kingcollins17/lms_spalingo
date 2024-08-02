// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lms_spalingo/pronounciation_controller.dart';
import 'package:lms_spalingo/screens/constants.dart';
import 'package:lms_spalingo/screens/pronounciation_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? filePath, word;

  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    //
    setState(() {
      filePath = result?.files.single.path;
    });
  }

  void submit() {
    if (filePath != null && word != null && word!.isNotEmpty) {
      final controller = Get.find<PronounciationController>();
      controller.add(word!, DeviceFileSource(filePath!));
      Get.snackbar('Success', '${word} has been added successfully');

      Future.delayed(Duration(seconds: 4), () => Get.off(PronounciationScreen()));
      
    } else {
      //assert(false, 'File path or word is null');
      Get.snackbar(
        'Error',
        'Either word or filepath has not been added, please fill the form',
      );
      

    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PronounciationController>();
    final currentTabIsWords = controller.currentTab == 'Words';

    final grey = Color(0xFF444444);
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('asset/logo.png'),
        title: Text('Add Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => word = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: 'Enter word',
                  labelText: 'Upload Word'),
            ),
            spacer(y: 30),
            GestureDetector(
              onTap: uploadFile,
              child: Container(
                width: screen(context).width,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration:
                    BoxDecoration(color: Color(0xFFDADADA), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_rounded,
                      size: 20,
                      color: grey,
                    ),
                    spacer(x: 10),
                    Text(
                      filePath != null ? filePath!.split('/').last : 'Tap to upload audio',
                      style: TextStyle(fontSize: 18, color: grey),
                    ),
                  ],
                ),
              ),
            ),
            spacer(y: 10),
            FilledButton(
                onPressed: submit,
                child: Text(
                  currentTabIsWords ? 'Upload Word' : 'Upload Number',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
