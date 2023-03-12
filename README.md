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
        ),
      ),
    ),
  );
}
```

Following are the embedding types:  

```EmbeddingChoice.dart```  : <img alt="Dart Embedding" height="480" src="https://github.com/aswanath/flutter_dartpad/blob/main/images/dart.png" width="270"/>
```EmbeddingChoice.flutterShowcase```  : ![Dart Embedding](https://github.com/aswanath/flutter_dartpad/blob/main/images/flutterShowcase.png)
```EmbeddingChoice.flutter```  : ![Dart Embedding](https://github.com/aswanath/flutter_dartpad/blob/main/images/flutter.png)
```EmbeddingChoice.html```  : ![Dart Embedding](https://github.com/aswanath/flutter_dartpad/blob/main/images/html.png)
```EmbeddingChoice.inline```  : ![Dart Embedding](https://github.com/aswanath/flutter_dartpad/blob/main/images/inline.png)
