// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_spalingo/pronounciation_controller.dart';
import 'package:lms_spalingo/screens/pronounciation_screen.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {

  AudioCache.instance = AudioCache(prefix: 'asset/');
  runApp(SpalingoApp());
}


class SpalingoApp extends StatelessWidget {
  const SpalingoApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PronounciationController());
    
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    //theme: ThemeData.dark();
    home: PronounciationScreen(),
    );
  }
}