//
//  ALObserverItem.h
//  Pods
//
//  Created by liubiao on 15/11/2.
//
//

#import <Foundation/Foundation.h>

@class ALObserverMsg;
/*!
 *  @brief  数据变化回调blcok
 *
 *  @param baseStore   数据的store
 *  @param dataChanged 数据变化详情
 *
 *  @return
 */
typedef  void(^ALObserverDistributeBlock)(id sender,ALObserverMsg *msg);

@interface ALObserverItem : NSObject

/*!
 *  @brief 监听者对象
 */
@property (nonatomic, weak) id observer;

/*!
 *  @brief  消息分发唯一标识符
 */
@property (nonatomic, copy) NSString *distributeIdentifier;

/*!
 *  @brief  数据变化时事件变化block
 */
@property (nonatomic, copy) ALObserverDistributeBlock block;

/*!
 *  @brief 消息发送的方法: SEL结构体的字符串
 */
@property (nonatomic, copy) NSString *selStr;

/*!
 *  @brief  用户自定义数据: NSDictionary中只能是简单数据类型或者实现了<copy>协议的自定义类型
 */
@property (nonatomic, copy) NSDictionary *userInfo;


@end
