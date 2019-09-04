//
//  DryFirebaseMessaging.m
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <UserNotifications/UserNotifications.h>
#import <FirebaseMessaging/FirebaseMessaging.h>

#import "DryFirebaseMessaging.h"

#pragma mark - 常量
static DryFirebaseMessaging *theInstance = nil;

#pragma mark - DryFirebaseMessaging
@interface DryFirebaseMessaging () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>

/// 推送通知回调Block
@property (nonatomic, readwrite, copy, nullable) BlockDryFirebaseMessagingNotification notificationBlock;
/// fcmToken回调Block
@property (nonatomic, readwrite, copy, nullable) BlockDryFirebaseMessagingFcmToken fcmTokenBlock;

@end

#pragma mark - DryFirebaseMessaging
@implementation DryFirebaseMessaging

/// 单例
+ (instancetype)sharedInstance {
    
    if (!theInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            theInstance = [[DryFirebaseMessaging alloc] init];
        });
    }
    
    return theInstance;
}

/// 构造
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

/// 析构
- (void)dealloc {
    
}

/// 注册推送
+ (void)registerApnsWithLaunchOptions:(nullable NSDictionary *)launchOptions
                          resultBlock:(void(^)(BOOL success))resultBlock
                        fcmTokenBlock:(BlockDryFirebaseMessagingFcmToken)fcmTokenBlock
                    notificationBlock:(BlockDryFirebaseMessagingNotification)notificationBlock {
    
    /// 设置Firebase推送回调代理
    [FIRMessaging messaging].delegate = [DryFirebaseMessaging sharedInstance];
    
    /// 设置: 当App处于前台时，是否直接通过 FIRMessagingDelegate 回调获取通知
    [FIRMessaging messaging].shouldEstablishDirectChannel = NO;
    
    /// 保存回调Block
    [DryFirebaseMessaging sharedInstance].fcmTokenBlock = fcmTokenBlock;
    [DryFirebaseMessaging sharedInstance].notificationBlock = notificationBlock;
    
    /// 注册系统推送
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = [DryFirebaseMessaging sharedInstance];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        /// 回调注册结果
        if (resultBlock) {
            resultBlock(granted);
        }
        
        /// 注册
        if (granted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }
    }];
    
    /// 检查启动推送消息
    if (launchOptions && [[launchOptions allKeys] containsObject:UIApplicationLaunchOptionsRemoteNotificationKey]) {
        
        /// 解析数据
        id userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (!userInfo || ![userInfo isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        /// 回调数据
        if ([DryFirebaseMessaging sharedInstance].notificationBlock) {
            [DryFirebaseMessaging sharedInstance].notificationBlock(userInfo);
        }
    }
}

/// 上报 Apple APNS deviceToken
+ (void)commitApnsDeviceToken:(nullable NSData *)deviceToken {
    [FIRMessaging messaging].APNSToken = deviceToken;
}

/// 订阅Topic
+ (void)subscribeToTopic:(nonnull NSString *)topic completion:(nonnull void(^)(BOOL success))completion {
    
    [[FIRMessaging messaging] subscribeToTopic:topic completion:^(NSError * _Nullable error) {
        
        if (completion && !error) {
            completion(YES);
        }else if (completion && error) {
            completion(NO);
        }
    }];
}

/// 取消订阅Topic
+ (void)unsubscribeFromTopic:(nonnull NSString *)topic completion:(nonnull void(^)(BOOL success))completion {
    
    [[FIRMessaging messaging] unsubscribeFromTopic:topic completion:^(NSError * _Nullable error) {
        
        if (completion && !error) {
            completion(YES);
        }else if (completion && error) {
            completion(NO);
        }
    }];
}

/// UNUserNotificationCenterDelegate: 推送通知(远程、本地)(前台)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
           willPresentNotification:(UNNotification *)notification
             withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    /// 回调数据
    if ([DryFirebaseMessaging sharedInstance].notificationBlock) {
        NSDictionary *userInfo = notification.request.content.userInfo;
        [DryFirebaseMessaging sharedInstance].notificationBlock(userInfo);
    }
    
    /// 回调: 前台显示通知的模式
    completionHandler(UNNotificationPresentationOptionNone);
}

/// UNUserNotificationCenterDelegate: 推送通知(远程、本地)(后台)(通过点击推送通知进入)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler {
    
    /// 回调数据
    if ([DryFirebaseMessaging sharedInstance].notificationBlock) {
        NSDictionary *userInfo = response.notification.request.content.userInfo;
        [DryFirebaseMessaging sharedInstance].notificationBlock(userInfo);
    }
    
    /// 回调
    completionHandler();
}

/// FIRMessagingDelegate: fcmToken回调
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    
    /// 回调fcmToken
    if ([DryFirebaseMessaging sharedInstance].fcmTokenBlock && fcmToken && fcmToken.length > 0) {
        [DryFirebaseMessaging sharedInstance].fcmTokenBlock(fcmToken);
    }
}

/// FIRMessagingDelegate: 当App处于前台时，回调通知，通过 [FIRMessaging messaging].shouldEstablishDirectChannel开关
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    
    /// 打印通知消息
    //NSLog(@"MRCFirebaseMessaging FCM data %@", remoteMessage.appData);
}

@end
