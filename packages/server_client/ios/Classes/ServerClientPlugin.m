#import "ServerClientPlugin.h"
#if __has_include(<server_client/server_client-Swift.h>)
#import <server_client/server_client-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "server_client-Swift.h"
#endif

@implementation ServerClientPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftServerClientPlugin registerWithRegistrar:registrar];
}
@end
