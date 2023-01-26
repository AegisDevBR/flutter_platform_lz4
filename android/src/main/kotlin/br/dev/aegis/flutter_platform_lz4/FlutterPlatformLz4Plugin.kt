package br.dev.aegis.flutter_platform_lz4

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPlatformLz4Plugin */
class FlutterPlatformLz4Plugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel

  companion object {
    private fun returnInvalidArguments(result: Result) {
      result.error(
        "INVALID_ARGUMENTS",
        "The arguments must be a byte array and the decompressed length of the data.",
        null,
      )
    }

    private fun handleDecompressBlock(arguments: Any, result: Result) {
      if (arguments !is List<*>) {
        returnInvalidArguments(result)
        return
      }

      val bytes = arguments[0]
      val decompressedLength = arguments[1]

      if (bytes !is ByteArray || decompressedLength !is Int) {
        returnInvalidArguments(result)
        return
      }

      result.success(decompressLZ4Block(bytes, decompressedLength))
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_platform_lz4")
    channel.setMethodCallHandler(this)

    teste()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "decompressBlock") {
      handleDecompressBlock(call.arguments, result)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
