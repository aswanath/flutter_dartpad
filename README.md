A dart pad which can be easily embedded to mobile application with the help of web view.
Supports all the features listed in dart pad [embedding guide](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide): 

NOTE: Performance won't be great as it is working on web view.

```
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
```EmbeddingChoice.dart```  : ![Dart Embedding](https://github.com/aswanath/flutter_dartpad/blob/master/dart.png)
