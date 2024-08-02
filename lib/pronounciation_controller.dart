// ignore_for_file: unused_field

import 'dart:io';
import 'dart:async';

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PronounciationController extends GetxController {
  final _player = AudioPlayer();

  final currentTab = 'Words'.obs;

  ///The word that is being played
  String? isPlaying;

  final words = <String, Source>{
    'Educacion - Education': AssetSource('Education.mp3'),
    'Intercambio - Exchange': AssetSource('Exchange.mp3'),
    'Hola - Hello': AssetSource('Hello.mp3'),
    'Bienvenido - Welcome': AssetSource('Welcome.mp3'),
    'Sabiduria - Wisdom': AssetSource('Wisdom.mp3'),
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
      isPlaying = word;
      update();
      await _player.play(words[word]!);
      await Future.delayed(Duration(seconds: 2));
      isPlaying = null;
      update();
    }
  }

  Future<void> pronounceNumber(String number) async {
    assert(numbers.containsKey(number));

    if (numbers.containsKey(number)) {
      isPlaying = number;
      update();
      
      await _player.play(numbers[number]!);
      await Future.delayed(Duration(seconds: 2));

      isPlaying = null;
      update();
    }
  }

  Future<void> addWord(String word, Source audio) async {
    words.putIfAbsent(word, () => audio);
    update();
  }

  Future<void> addNumber(String number, Source audio) async {
    numbers.putIfAbsent(number, () => audio);
    update();
  }

  Future<void> add(String word, Source audio) async {
    if (currentTab == 'Words') {
      await addWord(word, audio);
    } else
      await addNumber(word, audio);
  }

  void switchTab(String newTab) {
    currentTab.value = newTab;
    update();
  }
}
