# DryFirebase-iOS
iOS: Google Firebase功能简化集成(推送、统计、崩溃上报)
[官网](https://firebase.google.com/)
[Github](https://github.com/firebase/firebase-ios-sdk)

## Prerequisites
* iOS 10.0+
* ObjC、Swift

## Installation
* pod 'DryFirebase-iOS'
* 开发者需要把 GoogleService-Info.plist 文件导入项目工程中
[GoogleService-Info.plist](https://firebase.google.com/docs/ios/setup)

## Features
### 注册SDK
```
[DryFirebase registerSDK];
```
### 统计
```
/// 记录应用事件(同一个事件的名称和参数必须一样，最多支持500个事件名称，最多可包含25个参数)
+ (void)setUserPropertyString:(nullable NSString *)value forName:(nonnull NSString *)name;

/// 设置用户ID属性
+ (void)setUserID:(nullable NSString *)userID;

/// 设置当前屏幕名称
+ (void)setScreenName:(nullable NSString *)screenName screenClass:(nullable NSString *)screenClassOverride;

/// 此应用程序实例的唯一ID
+ (nonnull NSString *)appInstanceID;

/// 从设备清除此实例的所有分析数据并重置应用实例ID
+ (void)resetAnalyticsData;
```
### 推送
```
1、开发者需要把 GoogleService-Info.plist 文件导入项目工程中；

2、注册、接收推送消息对象:
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /// 注册推送
    [DryFirebaseMessaging registerApnsWithLaunchOptions:launchOptions resultBlock:^(BOOL success) {
        /// 是否注册成功
    } fcmTokenBlock:^(NSString * _Nullable fcmToken) {
        /// 将回调的fcmToken传递给服务端，用于服务端配置
    } notificationBlock:^(NSDictionary * _Nullable userInfo) {
        /// 在此处收到APNS推送
    }];

    return YES;
}

3、上报deviceToken到firebase:
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// 上报 Apple APNS deviceToken
    [DryFirebaseMessaging commitApnsDeviceToken:deviceToken];
}

4、订阅topic
[DryFirebaseMessaging subscribeToTopic:"topic" completion:^(BOOL success) {
    
}];
```
