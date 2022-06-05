import 'package:flutter/material.dart';

import '../../../core/theme/color_theme.dart';

class PlayGame extends StatelessWidget {
  const PlayGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Cards'),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
