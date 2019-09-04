//
//  DryFirebase.m
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <FirebaseCore/FirebaseCore.h>
#import <Fabric/Fabric.h>
#import "DryFirebase.h"

#pragma mark - DryFirebase
@implementation DryFirebase

/// 注册SDK(Analytics、Crash、Messaging)
+ (void)registerSDK {
    [FIRApp configure];
}

/// 开关Debug模式
+ (void)debugEnable:(BOOL)enable {
    [Fabric sharedSDK].debug = enable;
}

@end
