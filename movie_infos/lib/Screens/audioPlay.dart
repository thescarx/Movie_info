import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class AudioPlayerDemo extends StatefulWidget {
  String path;
  AudioPlayerDemo({Key? key,required this.path}) : super(key: key);

  @override
  _AudioPlayerDemoState createState() => _AudioPlayerDemoState();
}

class _AudioPlayerDemoState extends State<AudioPlayerDemo> {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio() async {
    int result = await audioPlayer.play(widget.path);
    if (result == 1) {
      // success
    } else {
      // failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            playAudio();
          },
          child: Text('Play Audio'),
        ),
      ),
    );
  }
}
