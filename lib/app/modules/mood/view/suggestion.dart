import 'package:emotion_detector/app/modules/mood/controller/mood_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/color_theme.dart';


class Suggestion extends StatefulWidget {
  const Suggestion({Key? key}) : super(key: key);

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {

    final MoodController moodController = Get.find();

    List _items = moodController.reccomendations;

    return Scaffold(
      appBar: AppBar(
        title: Text(moodController.label),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Here are some fun activities to help you improve your mood', style: TextStyle(
              fontSize: 22
            ),),
          ),
          const SizedBox(height: 16,),
          SingleChildScrollView(
              child: ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 1000),
                children: _getExpansionPanels(_items),
                expansionCallback: (panelIndex, isExpanded) {
                  _items[panelIndex].isExpanded = !isExpanded;
                  print(_items[panelIndex].isExpanded);
                  setState(() {
                  });
                },
              )
          ),
        ],
      ),
    );
  }
}
List<ExpansionPanel> _getExpansionPanels(List _items)
{
  return _items.map<ExpansionPanel>((ListItem item) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(item.headerName, style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),
          ),
        );
      },
      body: SizedBox(
        height: 300,
       child: ListView(
         children: item().map((e) =>  ListTile(
           leading: const Icon(Icons.music_note, size: 40,color: Colors.purple),
           title: Text(e.name),
           subtitle: Text(e.artist),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: const [
               Icon(Icons.play_circle_outline, size: 40, color: Colors.green,),
               Icon(Icons.stop, size: 40, color: Colors.red,)
             ],
           ),
         )).toList(),
       ),
      ),
      isExpanded: item.isExpanded,
    );
  }).toList();
}