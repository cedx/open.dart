path: blob/master
source: lib/src/io/open.dart

# Application programming interface
Use the `open()` function to a document or URL:

```dart
import 'package:open/open.dart';

Future<void> main() async {
  await open('https://belin.io');
}
```
