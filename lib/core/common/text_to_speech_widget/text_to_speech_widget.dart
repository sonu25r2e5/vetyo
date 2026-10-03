import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/services/text_to_speech_service.dart';
import 'package:vetyo/constants/app_colors.dart';

class TextToSpeechWidget extends StatefulWidget {
  final String textToSpeak;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onStart;
  final VoidCallback? onStop;

  const TextToSpeechWidget({
    super.key,
    required this.textToSpeak,
    this.iconSize,
    this.iconColor,
    this.onStart,
    this.onStop,
  });

  @override
  State<TextToSpeechWidget> createState() => _TextToSpeechWidgetState();
}

class _TextToSpeechWidgetState extends State<TextToSpeechWidget> {
  final TextToSpeechService _ttsService = TextToSpeechService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _ttsService.initializeTts();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _ttsService.stop();
      setState(() => _isPlaying = false);
      widget.onStop?.call();
    } else {
      await _ttsService.speak(widget.textToSpeak);
      setState(() => _isPlaying = true);
      widget.onStart?.call();
    }
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayback,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color:
              _isPlaying
                  ? ColorPalete.brightSky[100]
                  : ColorPalete.brightSky[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          _isPlaying ? Icons.stop_circle : Icons.volume_up,
          size: widget.iconSize ?? 24.sp,
          color: widget.iconColor ?? ColorPalete.brightSky[600],
        ),
      ),
    );
  }
}
