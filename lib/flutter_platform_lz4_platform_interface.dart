import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_platform_lz4_method_channel.dart';

abstract class FlutterPlatformLz4Platform extends PlatformInterface {
  /// Constructs a FlutterPlatformLz4Platform.
  FlutterPlatformLz4Platform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPlatformLz4Platform _instance =
      MethodChannelFlutterPlatformLz4();

  /// The default instance of [FlutterPlatformLz4Platform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPlatformLz4].
  static FlutterPlatformLz4Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPlatformLz4Platform] when
  /// they register themselves.
  static set instance(FlutterPlatformLz4Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Uint8List?> decompressBlock(
    Uint8List rawBytes,
    int decompressedLength,
  );
}
