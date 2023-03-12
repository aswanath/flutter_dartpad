import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constants.dart';

class Dartpad extends StatefulWidget {
  const Dartpad({
    Key? key,
    this.embeddingChoice = EmbeddingChoice.dart,
    this.darkMode = true,
    this.runImmediately = false,
    this.nullSafety = true,
    this.split,
    this.code,
    this.testCode,
    this.solutionCode,
    this.hintText,
    this.gistId,
    this.gaId,
  })  : assert(split == null || (split <= 100 && split >= 0)),
        assert(
          !(code != null && gistId != null),
          'Either code or gistId must be null, but not both.',
        ),
        super(key: key);

  /// The kind of dart pad widget to be generated.
  ///
  /// See: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide#embedding-choices
  final EmbeddingChoice embeddingChoice;

  /// Whether the widget should use dark mode styling.
  final bool darkMode;

  /// Whether the specified code should be run as soon as the widget is loaded.
  final bool runImmediately;

  /// Whether the editor should use null-safe dart.
  final bool nullSafety;

  /// The code to pre-load into the dart pad editor.
  ///
  /// To make [code] runnable, include a `main()` function in it. Note that
  /// [code] and the following optional [testCode] parameter will be run as if
  /// they were in the same file so should only define `main()` in one of the
  /// two.
  final String? code;

  /// Optional test code that can be displayed in the editor and used to
  /// reference and test the behavior of [code].
  ///
  /// This will run as if it were in the same file as [code] so you can
  /// reference any content in [code] from here. To run the tests, include a
  /// `main()` function here that calls them and do not include a main function
  /// in [code].
  ///
  /// Code here will have access to a hidden method:
  ///   `void _result(bool didPass, [List<String> failureMessages])`
  /// Call result with true to indicate that the test passed. Call it with false
  /// and optional failure messages to indicate that the test failed and why it
  /// failed.
  ///
  /// To view tests, users have to tap on the triple dot button in the editor
  /// and toggle their visibility.
  final String? testCode;

  /// Optional solution code.
  ///
  /// This is intended for codelab content where you are testing a user and
  /// want to show them the correct answer if they wish to see it.
  ///
  /// The solution code should be code that will make [testCode] pass.
  final String? solutionCode;

  /// Text that can be displayed as a message in the editor.
  ///
  /// This is intended for codelab content where you are testing
  /// a user's knowledge and want to give them an optional hint to help them
  /// solve the challenge.
  final String? hintText;

  /// The proportion of space (0-100) to give to code entry in the editor UI.
  ///
  /// For example, a value of 60 will fill the left 60% of the editor with code
  /// entry and the right 40% with console or UI output.
  /// [EmbeddingChoice.flutterShowcase] won't take account of split as it is not
  /// displaying as split screen.
  final int? split;

  /// Git Gist id of dart code which used to initialize the code editor with sample code.
  final String? gistId;

  ///Google analytics ID, used to identify separate samples in an article or codelab.
  ///Refer embedding guide for more info.
  final String? gaId;

  @override
  State<Dartpad> createState() => _DartpadState();
}

class _DartpadState extends State<Dartpad> {
  late WebViewController controller;

  Map<String, String> get sourceCodeFileMap {
    return {
      if (widget.code != null) 'main.dart': widget.code!,
      if (widget.testCode != null) 'test.dart': widget.testCode!,
      if (widget.solutionCode != null) 'solution.dart': widget.solutionCode!,
      if (widget.hintText != null) 'hint.txt': widget.hintText!,
    };
  }

  @override
  void initState() {
    super.initState();
    var link = Uri.https(
      kDartPadHost,
      _embeddingChoiceToString(widget.embeddingChoice),
      <String, String>{
        kThemeKey: widget.darkMode ? kDarkMode : kLightMode,
        kRunKey: widget.runImmediately.toString(),
        if (widget.split != null) kSplitKey: widget.split.toString(),
        kNullSafetyKey: widget.nullSafety.toString(),
        if (widget.gistId != null) kGistId: widget.gistId!,
        if (widget.gaId != null) kGaId: widget.gaId!,
      },
    );
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (_) {
            return NavigationDecision.prevent;
          },
          onProgress: (int progress) async {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            final m = {
              kSourceCode: sourceCodeFileMap,
              kType: kSourceCode,
            };
            final message = jsonEncode(m);
            controller.runJavaScript('''
             window.postMessage($message,'*');
             ''');
          },
        ),
      )
      ..loadRequest(
        link,
      );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}

/// The embedding type to use with dart pad.
///
/// See: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide#embedding-choices
enum EmbeddingChoice {
  dart,
  inline,
  flutter,
  html,
  flutterShowcase,
}

String _embeddingChoiceToString(EmbeddingChoice embeddingChoice) {
  late String choiceText;
  switch (embeddingChoice) {
    case EmbeddingChoice.dart:
      choiceText = 'dart';
      break;
    case EmbeddingChoice.inline:
      choiceText = 'inline';
      break;
    case EmbeddingChoice.flutter:
      choiceText = 'flutter';
      break;
    case EmbeddingChoice.html:
      choiceText = 'html';
      break;
    case EmbeddingChoice.flutterShowcase:
      choiceText = 'flutter_showcase';
      break;
  }
  return 'embed-$choiceText.html';
}
