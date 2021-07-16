import 'dart:ffi';
import 'dart:io' show Platform;


// For C/Rust
typedef add_func = Int64 Function(Int64 a, Int64 b);
// For Dart
typedef Add = int Function(int a, int b);


DynamicLibrary load({String basePath = ''}) {
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('${basePath}libserver_client_ffi.so');
  } else if (Platform.isIOS) {
    // iOS is statically linked, so it is the same as the current process
    return DynamicLibrary.process();
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('${basePath}libserver_client_ffi.dylib');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('${basePath}libserver_client_ffi.dll');
  } else {
    throw NotSupportedPlatform('${Platform.operatingSystem} is not supported!');
  }
}

class NotSupportedPlatform implements Exception {
  NotSupportedPlatform(String s);
}


class Adder {
  static DynamicLibrary _lib = load();

  Adder() {
    // for debugging and tests
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      //_lib = load(basePath: '../../../target/debug/');
    } else {
      _lib = load();
    }
  }

  int add(int a, int b) {
    // get a function pointer to the symbol called `add`
    final addPointer = _lib.lookup<NativeFunction<add_func>>('add');
    // and use it as a function
    final sum = addPointer.asFunction<Add>();
    return sum(a, b);
  }
}