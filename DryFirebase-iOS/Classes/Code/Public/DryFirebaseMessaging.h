//
//  DryFirebaseMessaging.h
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

 #pragma mark - Block
/// fcmToken回调
typedef void (^BlockDryFirebaseMessagingFcmToken)       (NSString *_Nullable fcmToken);
/// 推送通知回调
typedef void (^BlockDryFirebaseMessagingNotification)   (NSDictionary *_Nullable userInfo);

#pragma mark - 推送
@interface DryFirebaseMessaging : NSObject

/// @说明 注册推送
/// @注释 必须在(application: didFinishLaunchingWithOptions:)中调用
/// @参数 launchOptions:      启动系统返回
/// @参数 resultBlock:        注册结果回调
/// @参数 fcmTokenBlock:      Google回调的fcmToken，用于提交服务端
/// @参数 notificationBlock:  推送通知回调
/// @返回 void
+ (void)registerApnsWithLaunchOptions:(nullable NSDictionary *)launchOptions
                          resultBlock:(void(^)(BOOL success))resultBlock
                        fcmTokenBlock:(BlockDryFirebaseMessagingFcmToken)fcmTokenBlock
                    notificationBlock:(BlockDryFirebaseMessagingNotification)notificationBlock;

/// @说明 上报 Apple APNS deviceToken
/// @注释 必须在(application: didRegisterForRemoteNotificationsWithDeviceToken:)中调用
/// @参数 deviceToken:    iOS系统下发的推送唯一标识
/// @返回 void
+ (void)commitApnsDeviceToken:(nullable NSData *)deviceToken;

/// @说明 订阅Topic
/// @参数 topic:      topic名称
/// @参数 completion: 订阅结果回调
/// @返回 void
+ (void)subscribeToTopic:(nonnull NSString *)topic completion:(nonnull void(^)(BOOL success))completion;

/// @说明 取消订阅Topic
/// @参数 topic       topic名称
/// @参数 completion: 取消订阅结果回调
/// @返回 void
+ (void)unsubscribeFromTopic:(nonnull NSString *)topic completion:(nonnull void(^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
