WTSafeGuard can effectively prevent the IOS system application crash
### Features
- Avoid UIKit Called on Non-Main Thread crash
- Avoid KVO crash
- Avoid unrecognized selector crash
- Avoid Container NSArray， NSMutableArray, NSDictionary, NSMutableDictionary, NSSet, NSMutableSet crash
- Avoid NSString， NSMutableString,NSAttributedString  crash
- Avoid NSURL,  NSFileManager, NSIndexPath, NSJSONSerialization

### Requirements
- IOS 8 or later , XCode 7 or later

### How To Use
```Objc
#import "WTSafeGuard.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    [WTSafeGuard startSafeGuard];
}
```
### Installation
- pod 'WTSafeGuard'
