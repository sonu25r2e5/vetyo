import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused }

class TextToSpeechService {
  static final TextToSpeechService _instance = TextToSpeechService._internal();

  factory TextToSpeechService() {
    return _instance;
  }

  TextToSpeechService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState = TtsState.stopped;

  TtsState get ttsState => _ttsState;
  bool get isPlaying => _ttsState == TtsState.playing;
  bool get isPaused => _ttsState == TtsState.paused;

  Future<void> initializeTts() async {
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      _flutterTts.setCompletionHandler(_handleTtsCompletion);
      _flutterTts.setErrorHandler(_handleTtsError);
    } catch (e) {
      print("Error initializing TTS: $e");
    }
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;

    try {
      _ttsState = TtsState.playing;
      await _flutterTts.speak(text);
    } catch (e) {
      print("Error speaking: $e");
      _ttsState = TtsState.stopped;
    }
  }

  Future<void> pause() async {
    try {
      await _flutterTts.pause();
      _ttsState = TtsState.paused;
    } catch (e) {
      print("Error pausing: $e");
    }
  }

  Future<void> resume() async {
    try {
      await _flutterTts.setLanguage("en-US");
      _ttsState = TtsState.playing;
    } catch (e) {
      print("Error resuming: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      _ttsState = TtsState.stopped;
    } catch (e) {
      print("Error stopping: $e");
    }
  }

  Future<void> setSpeechRate(double rate) async {
    try {
      await _flutterTts.setSpeechRate(rate);
    } catch (e) {
      print("Error setting speech rate: $e");
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _flutterTts.setVolume(volume);
    } catch (e) {
      print("Error setting volume: $e");
    }
  }

  Future<void> setPitch(double pitch) async {
    try {
      await _flutterTts.setPitch(pitch);
    } catch (e) {
      print("Error setting pitch: $e");
    }
  }

  void _handleTtsCompletion() {
    _ttsState = TtsState.stopped;
  }

  void _handleTtsError(dynamic error) {
    _ttsState = TtsState.stopped;
    print("TTS Error: $error");
  }

  Future<void> dispose() async {
    await stop();
  }
}
