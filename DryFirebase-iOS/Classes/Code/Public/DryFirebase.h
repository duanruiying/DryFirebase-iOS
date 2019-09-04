//
//  DryFirebase.h
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SDK配置
@interface DryFirebase : NSObject

/// @说明 注册SDK(Analytics、Crash、Messaging)
/// @注释 开发者需要把 GoogleService-Info.plist 文件导入工程中
/// @返回 void
+ (void)registerSDK;

/// @说明 开关Debug模式
/// @参数 enable: 开关
/// @返回 void
+ (void)debugEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
