import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:movie_infos/Screens/audioPlay.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/itemList.dart';
import '../Widgets/audioplayer.dart';
class ItemScreen extends StatefulWidget {

  Note note;
  ItemScreen({Key? key,required this.note}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

  String filee='';
  List<double> list=[];
  String dat='';
  _load(){
    setState(() {
      dat=DateFormat('E MMM dd HH:mm:ss y').format(widget.note.date);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
    saveTtsToCache(widget.note.description);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text('Notes'),
        actions: [

        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children:  [
              Container(
                height: 200,
                width: 150,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
             const SizedBox(height: 20,),
             if(widget.note.title!=null) Text(widget.note.title,style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Text(widget.note.description,style: const TextStyle(color: Colors.grey,fontWeight:FontWeight.w500),),
              const SizedBox(height: 20,),
              Text(dat,style: const TextStyle(color: Colors.grey,fontWeight:FontWeight.w500)),
              const SizedBox(height: 20,),
             if(filee.isNotEmpty) AudioPlayerWidget(audioUrl: filee)

            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveTtsToCache(String text) async {
    final FlutterTts flutterTts = FlutterTts();
    final String filename = '${text.hashCode.toString()}';

    // Configure TTS
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    print(filename);
    // Generate audio from text
    await flutterTts.synthesizeToFile(text, filename);
    final Directory? directory = await getExternalStorageDirectory();
    final String filePath = '${directory!.path}/$filename';
    print(filePath);
    setState(() {
      filee=filePath;
    });

    // _loadData(filePath);
  }
}



