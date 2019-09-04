//
//  DryFirebaseAnalytics.m
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <FirebaseAnalytics/FirebaseAnalytics.h>
#import "DryFirebaseAnalytics.h"

#pragma mark - DryFirebaseAnalytics
@implementation DryFirebaseAnalytics

/// 记录应用事件
+ (void)logEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    
    if (name) {
        [FIRAnalytics logEventWithName:name parameters:parameters];
    }
}

/// 设置用户属性名称为指定的值
+ (void)setUserPropertyString:(nullable NSString *)value forName:(NSString *)name {
    
    if (name) {
        [FIRAnalytics setUserPropertyString:value forName:name];
    }
}

/// 设置用户ID属性
+ (void)setUserID:(nullable NSString *)userID {
    [FIRAnalytics setUserID:userID];
}

/// 设置当前屏幕名称
+ (void)setScreenName:(nullable NSString *)screenName screenClass:(nullable NSString *)screenClassOverride {
    [FIRAnalytics setScreenName:screenName screenClass:screenClassOverride];
}

/// 此应用程序实例的唯一ID
+ (NSString *)appInstanceID {
    return [FIRAnalytics appInstanceID];
}

/// 从设备清除此实例的所有分析数据并重置应用实例ID
+ (void)resetAnalyticsData {
    [FIRAnalytics resetAnalyticsData];
}

@end
