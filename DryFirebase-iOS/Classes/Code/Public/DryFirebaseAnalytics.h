//
//  DryFirebaseAnalytics.h
//  DryFirebase
//
//  Created by Ruiying Duan on 2019/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 统计
@interface DryFirebaseAnalytics : NSObject

/// @说明 记录应用事件(同一个事件的名称和参数必须一样，最多支持500个事件名称，最多可包含25个参数)
///
/// @参数 name:       事件名称
/// 【1】事件名称的组成: 必须以字母开头，1到40个字母、数字、下划线组成，区分大小写
/// 【2】事件名称的保留前缀: "firebase_"、"google_"、"ga_"
/// 【3】事件名称的保留列表:
///  ad_activeview
///  ad_click
///  ad_exposure
///  ad_impression
///  ad_query
///  adunit_exposure
///  app_clear_data
///  app_remove
///  app_update
///  error
///  first_open
///  in_app_purchase
///  notification_dismiss
///  notification_foreground
///  notification_open
///  notification_receive
///  os_update
///  screen_view
///  session_start
///  user_engagement
///
/// @参数 parameters: 事件参数
/// 【1】无参数传递nil
/// 【2】参数key的组成: 必须以字母开头，并且只包含"字母"、"数字"、"下划线"，最长40个字符
/// 【3】参数key的保留前缀: "firebase_"、"google_"、"ga_"
/// 【4】参数value: 仅支持NSString和NSNumber(带符号的64位整数和64位浮点数)
/// 【5】参数value: NSString参数值最长可达100个字符
///
/// @返回 void
+ (void)logEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters;

/// @说明 设置用户属性名称为指定的值
/// @注释 最多支持25个用户属性名称；设置后，用户属性值将在整个应用程序生命周期和会话期间保持不变
///
/// @参数 value:  指定的值
/// 【1】值最长可达36个字符
/// 【2】将值设置为nil将删除用户属性
///
/// @参数 name:   用户属性名称
/// 【1】必须以字母开头，1到24个字母、数字、下划线组成
/// 【2】用户属性名称的保留前缀: "firebase_"、"google_"、"ga_"
/// 【3】用户属性名称的保留列表:
///  first_open_time
///  last_deep_link_referrer
///  user_id
///
/// @返回 void
+ (void)setUserPropertyString:(nullable NSString *)value forName:(NSString *)name;

/// @说明 设置用户ID属性
/// @注释 Google的隐私政策: <a href="https://www.google.com/policies/privacy"> </a>
/// @参数 userID: 用户标识(不能为空字符串；为nil表示删除用户标识)
/// @返回 void
+ (void)setUserID:(nullable NSString *)userID;

/// @说明 设置当前屏幕名称
///
/// @注释 以下要点请注意:
/// 【1】必须在主线程上调用
/// 【2】必须在 [super viewDidAppear:] 之后调用
/// 【2】只要UIViewController实现了viewDidAppear并且调用[super viewDidAppear:]，会自动跟踪该屏幕类进行统计
/// 【3】可以选择通过在UIViewController的viewDidAppear回调中调用此方法并指定screenClassOverride参数来覆盖类名
///
/// @参数 screenName:             屏幕名称(1到100个字符；设置为nil代表清除当前屏幕名称)
/// @参数 screenClassOverride:    屏幕类的名称(1到100个字符；默认情况下，这是当前UIViewController的类名；设置为nil以恢复默认的类名)
/// @返回 void
+ (void)setScreenName:(nullable NSString *)screenName screenClass:(nullable NSString *)screenClassOverride;

/// @说明 此应用程序实例的唯一ID
/// @返回 NSString
+ (NSString *)appInstanceID;

/// @说明 从设备清除此实例的所有分析数据并重置应用实例ID
/// @注释 FIRAnalyticsConfiguration值将重置为默认值
/// @返回 void
+ (void)resetAnalyticsData;

@end

NS_ASSUME_NONNULL_END
