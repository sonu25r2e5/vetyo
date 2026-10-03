import 'package:flutter/material.dart';
import 'package:vetyo/core/services/text_to_speech_service.dart';

class TextToSpeechProvider extends ChangeNotifier {
  final TextToSpeechService _ttsService = TextToSpeechService();
  String? _currentlyPlayingText;
  bool _isInitialized = false;

  String? get currentlyPlayingText => _currentlyPlayingText;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _ttsService.isPlaying;
  bool get isPaused => _ttsService.isPaused;

  Future<void> initialize() async {
    if (!_isInitialized) {
      await _ttsService.initializeTts();
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }
    _currentlyPlayingText = text;
    await _ttsService.speak(text);
    notifyListeners();
  }

  Future<void> pause() async {
    await _ttsService.pause();
    notifyListeners();
  }

  Future<void> resume() async {
    await _ttsService.resume();
    notifyListeners();
  }

  Future<void> stop() async {
    await _ttsService.stop();
    _currentlyPlayingText = null;
    notifyListeners();
  }

  Future<void> setSpeechRate(double rate) async {
    await _ttsService.setSpeechRate(rate);
  }

  Future<void> setVolume(double volume) async {
    await _ttsService.setVolume(volume);
  }

  Future<void> setPitch(double pitch) async {
    await _ttsService.setPitch(pitch);
  }

  @override
  Future<void> dispose() async {
    await _ttsService.dispose();
    super.dispose();
  }
}
