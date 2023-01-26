import 'package:flutter/services.dart';
import 'package:flutter_platform_lz4/flutter_platform_lz4_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelFlutterPlatformLz4 platform = MethodChannelFlutterPlatformLz4();
  const MethodChannel channel = MethodChannel('flutter_platform_lz4');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return Uint8List.fromList([1, 2, 3]);
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    final expectedResult = Uint8List.fromList([1, 2, 3]);
    expect(await platform.decompressBlock(Uint8List(0), 0), expectedResult);
  });
}
