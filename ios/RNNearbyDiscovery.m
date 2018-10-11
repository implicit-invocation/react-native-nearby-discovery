#import "RNNearbyManager.h"
#import "Discovery.h"

@interface RNNearbyDiscovery ()
@property (strong, nonatomic) Discovery *discovery;
@end

@implementation RNNearbyDiscovery

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"userChanged", @"pong"];
}

RCT_EXPORT_METHOD(init:(NSString*)id) {
  CBUUID *uuid = [CBUUID UUIDWithString:id];
  _discovery = [[Discovery alloc] initWithUUID:uuid];
}

RCT_EXPORT_METHOD(startAdvertisingWithUsername:(NSString*)username) {
  [_discovery startAdvertisingWithUsername:username];
}

RCT_EXPORT_METHOD(stopAdvertising:(NSString*)username) {
  [_discovery stopAdvertising];
}

RCT_EXPORT_METHOD(stopDiscovering:(NSString*)username) {
  [_discovery stopDiscovering];
}

RCT_EXPORT_METHOD(startDiscovering) {
  [_discovery startDiscovering:^(NSArray *users, BOOL usersChanged) {
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:[users count]];
    [users enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
      BLEUser* user = (BLEUser*)obj;
      result[index] = (NSString*)[user username];
    }];
    [self sendEventWithName:@"userChanged" body:result];
  }];
}

RCT_EXPORT_METHOD(ping) {
  [self sendEventWithName:@"pong" body:@[@"dcm", @"vcl"]];
}


@end
