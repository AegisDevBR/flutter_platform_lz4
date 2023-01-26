#import "FlutterPlatformLz4Plugin.h"
#if __has_include(<flutter_platform_lz4/flutter_platform_lz4-Swift.h>)
#import <flutter_platform_lz4/flutter_platform_lz4-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_platform_lz4-Swift.h"
#endif

@implementation FlutterPlatformLz4Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPlatformLz4Plugin registerWithRegistrar:registrar];
}
@end
