#import "BaseArPlugin.h"
#if __has_include(<base_ar/base_ar-Swift.h>)
#import <base_ar/base_ar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "base_ar-Swift.h"
#endif

@implementation BaseArPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBaseArPlugin registerWithRegistrar:registrar];
}
@end
