import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  Stopwatch _stopwatch = Stopwatch();

  Future<void> startRecording() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _audioRecorder!.openRecorder();
    await _audioRecorder!.startRecorder();

    _isRecording = true;
    _stopwatch.start();
  }

  Future<String?> stopRecording() async {
    String? result = await _audioRecorder!.stopRecorder();
    await _audioRecorder!.closeRecorder();

    _audioRecorder = null;
    _isRecording = false;
    _stopwatch.stop();

    return result; // Return the path of the recorded audio file
  }

  Duration get recordingDuration => _stopwatch.elapsed;

  bool get isRecording => _isRecording;
}

class RecordingPermissionException implements Exception {
  final String message;
  RecordingPermissionException(this.message);
}
