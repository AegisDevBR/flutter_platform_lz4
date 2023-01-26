import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_platform_lz4_platform_interface.dart';

class MethodChannelFlutterPlatformLz4 extends FlutterPlatformLz4Platform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_platform_lz4');

  @override
  Future<Uint8List?> decompressBlock(
    Uint8List rawBytes,
    int decompressedLength,
  ) async {
    final decompressed = await methodChannel.invokeMethod<Uint8List>(
      'decompressBlock',
      [rawBytes, decompressedLength],
    );
    return decompressed;
  }
}
