import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  AudioPlayerWidget({required this.audioUrl});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();
  StreamSubscription<Duration>? _positionSubscription;

  @override
  void dispose() {
    super.dispose();
    _positionSubscription?.cancel();
    _audioPlayer.release();
    _audioPlayer.dispose();
  }

  void _playAudio() async {
    int result = await _audioPlayer.play(widget.audioUrl);
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
      _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((p) {
        setState(() {
          _position = p;
        });
      });
      _audioPlayer.onDurationChanged.listen((d) {
        setState(() {
          _duration = d;
        });
      });
    }
  }

  void _stopAudio() async {
    int result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
        _position = Duration();
      });
      _positionSubscription?.cancel();
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          thumbColor: Colors.deepPurple,
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
              onPressed: _isPlaying ? _stopAudio : _playAudio,
            ),
            Text(_printDuration(_position)),
            Text(' / '),
            Text(_printDuration(_duration)),
          ],
        ),
      ],
    );
  }
}
