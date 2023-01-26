import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_lz4/flutter_platform_lz4.dart';
import 'package:flutter_platform_lz4/lz4_decompress_error.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _decompressedString;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? decompressedString;
    try {
      final bytes = Uint8List.fromList([64, 84, 101, 115, 116]);
      final decompressedBytes =
          await FlutterPlatformLz4.decompressBlock(bytes, 4);

      decompressedString = String.fromCharCodes(decompressedBytes);
    } on PlatformException {
      _hasError = true;
    } on LZ4DecompressError {
      _hasError = true;
    }

    if (!mounted) return;

    setState(() {
      _decompressedString = decompressedString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_hasError
              ? 'Error decompressing bytes'
              : 'Decompressed string: $_decompressedString\n'),
        ),
      ),
    );
  }
}
