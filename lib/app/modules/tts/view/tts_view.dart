import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/theme/color_theme.dart';

class TtsView extends StatelessWidget {
  TtsView({Key? key}) : super(key: key);

  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();


  speak(String text )async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Speech'),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(  //Instead of ListView or SingleChildScrollView put CustomScrollVIew to use Expanded or spacer
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 15,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => speak(textEditingController.text),
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.symmetric(vertical: 32),
                      child: const CircleAvatar(
                        backgroundColor: primaryColor,

                        child: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],),
            ),
          ),],
      ),

    );
  }
}
