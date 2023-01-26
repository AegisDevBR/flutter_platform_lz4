import 'dart:typed_data';

import 'package:flutter_platform_lz4/lz4_decompress_error.dart';

import 'flutter_platform_lz4_platform_interface.dart';

class FlutterPlatformLz4 {
  FlutterPlatformLz4._();

  /// Decompresses the given LZ4 block (without headers) in [rawBytes]. Requires
  /// the [decompressedLength], the length of the decompressed data, to be
  /// previously known. Throws a [LZ4DecompressError] if the decompress failed,
  /// e.g when the given data is not a valid LZ4 block, and may throw a
  /// [PlatformException] if something went wrong with the communication between
  /// Flutter and the platform.
  ///
  /// On iOS, the `COMPRESSION_LZ4_RAW` algorithm from the Compression framework
  /// is used. On Android, the Apache Commons Compression library is used.
  static Future<Uint8List> decompressBlock(
    Uint8List rawBytes,
    int decompressedLength,
  ) async {
    final decompressedBytes = await FlutterPlatformLz4Platform.instance
        .decompressBlock(rawBytes, decompressedLength);

    if (decompressedBytes == null) {
      throw LZ4DecompressError();
    }

    return decompressedBytes;
  }
}
