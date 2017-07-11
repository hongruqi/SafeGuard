WTSafeGuard can effectively prevent the IOS system application crash
### Features
UI 保持在主线程执行
KVO
Target 
Container

### Requirements
- IOS 8

### How To Use
```Objc
#import "WTSafeGuard.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    [WTSafeGuard startSafeGuard];
}
```
### Installation
- pod 'WTSafeGuard'
