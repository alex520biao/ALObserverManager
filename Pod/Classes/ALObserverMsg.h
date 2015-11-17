//
//  ALObserverMsg.h
//  Pods
//
//  Created by liubiao on 15/11/14.
//
//

#import <Foundation/Foundation.h>

@interface ALObserverMsg : NSObject

/*!
 *  @brief  消息发送者 sender,弱引用
 */
@property (nonatomic, weak) id sender;

/*!
 *  @brief  消息identifier
 */
@property (nonatomic, copy) NSString *distributeIdentifier;

/*!
 *  @brief  消息内容
 */
@property (nonatomic, strong) id payload;

/*!
 *  @brief  用户自定义数据: NSDictionary中只能是简单数据类型或者实现了<copy>协议的自定义类型
 */
@property (nonatomic, copy) NSDictionary *userInfo;



@end
