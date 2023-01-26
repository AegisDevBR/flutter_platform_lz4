import 'dart:typed_data';

import 'package:flutter_platform_lz4/flutter_platform_lz4.dart';
import 'package:flutter_platform_lz4/flutter_platform_lz4_method_channel.dart';
import 'package:flutter_platform_lz4/flutter_platform_lz4_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPlatformLz4Platform
    with MockPlatformInterfaceMixin
    implements FlutterPlatformLz4Platform {
  @override
  Future<Uint8List?> decompressBlock(
    Uint8List rawBytes,
    int decompressedLength,
  ) async {
    return Uint8List.fromList([1, 2, 3]);
  }
}

void main() {
  final FlutterPlatformLz4Platform initialPlatform =
      FlutterPlatformLz4Platform.instance;

  test('$MethodChannelFlutterPlatformLz4 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPlatformLz4>());
  });

  test('getPlatformVersion', () async {
    MockFlutterPlatformLz4Platform fakePlatform =
        MockFlutterPlatformLz4Platform();
    FlutterPlatformLz4Platform.instance = fakePlatform;

    final expectedResult = Uint8List.fromList([1, 2, 3]);

    expect(
      await FlutterPlatformLz4.decompressBlock(Uint8List(0), 0),
      expectedResult,
    );
  });
}
