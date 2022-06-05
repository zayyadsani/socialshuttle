import 'package:flutter/material.dart';

import '../../../core/theme/color_theme.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({Key? key}) : super(key: key);

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
