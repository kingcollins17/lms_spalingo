// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_spalingo/pronounciation_controller.dart';
import 'package:lms_spalingo/screens/screens.dart';

import 'constants.dart';

class PronounciationScreen extends StatelessWidget {
  const PronounciationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PronounciationController>();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('asset/logo.png', width: 20),
        title: Text('Spanlingo', style: TextStyle()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(UploadScreen()),
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Column(
          children: [
            Obx(() {
              return _CustomTabBar(
                currentTab: controller.currentTab.value,
                onTabChanged: controller.switchTab,
              );
            }),
            Obx(() {
              final currentTabIsWords = controller.currentTab == 'Words';
              return Column(
                children: [
                  //Text(controller.isPlaying.toString()),
                  ...currentTabIsWords
                      ? controller.words.keys.map((word) => _PronounciationTile(
                            wordOrNumber: word,
                            isWord: true,
                          ))
                      : controller.numbers.keys.map((number) => _PronounciationTile(
                            wordOrNumber: number,
                            isWord: false,
                          ))
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar({super.key, required this.currentTab, this.onTabChanged});
  final String currentTab;
  final void Function(String)? onTabChanged;

  Widget _buildTab(String name) {
    final bool isCurrentTab = name == currentTab;
    return GestureDetector(
      onTap: onTabChanged == null ? null : () => onTabChanged!(name),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color: isCurrentTab ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 16, color: isCurrentTab ? Colors.white : Colors.black),
              ),
            ));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabHeight = 50.0;
    var borderRadius = BorderRadius.circular(6);
    return Container(
      width: screen(context).width,
      height: tabHeight,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(color: Color(0xFFDCDCDC), borderRadius: borderRadius),
      child: Row(
        children: [Expanded(child: _buildTab('Words')), Expanded(child: _buildTab('Numbers'))],
      ),
    );
  }
}

class _PronounciationTile extends GetWidget<PronounciationController> {
  const _PronounciationTile({super.key, required this.wordOrNumber, required this.isWord});
  final String wordOrNumber;
  final bool isWord;

  void playAudio() {
    if (isWord) {
      controller.pronounceWord(wordOrNumber);
    } else {
      controller.pronounceNumber(wordOrNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: playAudio,
      child: Container(
        width: screen(context).width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 2),
            color: Color(0x77111111),
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              wordOrNumber,
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.play_circle, size: 25),
          ],
        ),
      ),
    );
  }
}
