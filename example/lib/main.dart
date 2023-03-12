import 'package:flutter/material.dart';
import 'package:flutter_dartpad/flutter_dartpad.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Dartpad(
            darkMode: false,
            runImmediately: true,
            embeddingChoice: EmbeddingChoice.inline,
            code: 'void main() { print("Hello DartPad");}',
          ),
        ),
      ),
    ),
  );
}
