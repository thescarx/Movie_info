import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String text="yahia boukharouba is a bitch";
  PlayerController controller = PlayerController();

  _loadData(path) async {
    await controller.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveTtsToCache(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Notes')),
      ),
      body: Center(
        child: Column(
          children:  [
           const SizedBox(
              height: 100,
              width: 100,
              child: Icon(Icons.file_copy_rounded),
            ),
           const SizedBox(height: 20,),
           const Text("Nadia Elouali",style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 20,),
            Text(text,style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 20,),
            Text(DateTime.now().toString()),
            const SizedBox(height: 20,),
        AudioFileWaveforms(
            size: Size(MediaQuery.of(context).size.width, 100.0),
            playerController: controller,
            enableSeekGesture: true,
            waveformType: WaveformType.long,
            waveformData: [],
            playerWaveStyle: const PlayerWaveStyle(
                fixedWaveColor: Colors.white54,
                liveWaveColor: Colors.blueAccent,
                spacing: 6,
            ),
        )
          ],
        ),
      ),
    );
  }

  Future<void> saveTtsToCache(String text) async {
    final FlutterTts flutterTts = FlutterTts();
    final String filename = text.hashCode.toString();

    // Configure TTS
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    print(filename);
    // Generate audio from text
    await flutterTts.synthesizeToFile(text, filename);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$filename';
    print(filePath);

     _loadData('/storage/emulated/0/Android/data/com.example.movie_infos/files/520438672');
  }
}

