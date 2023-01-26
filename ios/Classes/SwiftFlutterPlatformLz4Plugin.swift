import Flutter
import UIKit

public class SwiftFlutterPlatformLz4Plugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_platform_lz4", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterPlatformLz4Plugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "decompressBlock":
            handleDecompressBlock(arguments: call.arguments, result: result)
        default:
            result(FlutterError())
        }
    }
    
    func handleDecompressBlock(arguments: Any?, result: FlutterResult) {
        guard let arguments = arguments as? [Any],
              arguments.count == 2,
              let typedData = arguments[0] as? FlutterStandardTypedData,
              let length = arguments[1] as? Int
        else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "The arguments must be a byte array and the decompressed length of the data.",
                details: nil))
            return
        }
        
        let data = typedData.data
        let decompressedData = Data(rawLZ4CompressedData: data, decompressedLength: length)
        
        result(decompressedData)
    }
}
