// ignore_for_file: unused_field

import 'dart:io';
import 'dart:async';

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PronounciationController extends GetxController {
  final _player = AudioPlayer();

  final currentTab = 'Words'.obs;

  final isPlaying = false.obs;

  final words = <String, Source>{
    //'One': AssetSource('one.wav'),
    //'Two': AssetSource('two.wav'),
    //'Three': AssetSource('three.wav'),
    //'Four': AssetSource('four.wav'),
    //'Five': AssetSource('five.wav'),
    //'Six': AssetSource('six.wav'),
    //'Seven': AssetSource('seven.wav'),
    //'Eight': AssetSource('eight.wav'),
    //'Nine': AssetSource('nine.wav'),
    //'Ten': AssetSource('ten.wav'),
  }.obs;

  final numbers = <String, Source>{
    'One': AssetSource('one.wav'),
    'Two': AssetSource('two.wav'),
    'Three': AssetSource('three.wav'),
    'Four': AssetSource('four.wav'),
    'Five': AssetSource('five.wav'),
    'Six': AssetSource('six.wav'),
    'Seven': AssetSource('seven.wav'),
    'Eight': AssetSource('eight.wav'),
    'Nine': AssetSource('nine.wav'),
    'Ten': AssetSource('ten.wav'),
  }.obs;

  Future<void> pronounceWord(String word) async {
    assert(words.containsKey(word));
    if (words.containsKey(word)) {
      isPlaying.value = true;
      return _player.play(words[word]!).whenComplete(() => isPlaying.value = false);
    }
  }

  Future<void> pronounceNumber(String number) async {
    assert(numbers.containsKey(number));

    if (numbers.containsKey(number)) {
      isPlaying.value = true;
      return _player.play(numbers[number]!).whenComplete(() => isPlaying.value = false);
      
    }
  }


  Future<void> addWord(String word, Source audio) async {
    words.putIfAbsent(word, () => audio);
  }

  Future<void> addNumber(String number, Source audio) async {
    numbers.putIfAbsent(number, () => audio);
  }

  Future<void> add(String word, Source audio) async {
    if (currentTab == 'Words') {
      await addWord(word, audio);
    } else
      await addNumber(word, audio);
  }

  void switchTab(String newTab) => currentTab.value = newTab;
}
