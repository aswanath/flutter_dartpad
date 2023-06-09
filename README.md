A dart pad which can be easily embedded to mobile application with the help of web view.  
Supports all the features listed in dart pad [embedding guide](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide)   

NOTE: Performance won't be great as it is working on web view.  

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dartpad/flutter_dartpad.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: DartPad(
          code: 'void main() => print("Hello DartPad Widget");',
          embeddingChoice: EmbeddingChoice.dart,
        ),
      ),
    ),
  );
}
```

Following are the embedding choices:  

```dart
EmbeddingChoice.dart
```  
<img alt="Dart Embedding" height="480" src="https://raw.githubusercontent.com/aswanath/flutter_dartpad/main/images/dart.png" width="270"/>  

```dart
EmbeddingChoice.flutterShowcase
```  
<img alt="Flutter Showcase Embedding" height="480" src="https://raw.githubusercontent.com/aswanath/flutter_dartpad/main/images/flutter_showcase.png" width="270"/>

```dart
EmbeddingChoice.flutter
```  
<img alt="Flutter Embedding" height="480" src="https://raw.githubusercontent.com/aswanath/flutter_dartpad/main/images/flutter.png" width="270"/>  

```dart
EmbeddingChoice.html
```  
<img alt="HTML Embedding" height="480" src="https://raw.githubusercontent.com/aswanath/flutter_dartpad/main/images/html.png" width="270"/>  

```dart
EmbeddingChoice.inline
```  
<img alt="Inline Embedding" height="480" src="https://raw.githubusercontent.com/aswanath/flutter_dartpad/main/images/inline.png" width="270"/>  


Inspired to make this package and some code was borrowed from [dart_pad_widget](https://pub.dev/packages/dart_pad_widget)
