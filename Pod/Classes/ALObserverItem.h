//
//  ALObserverItem.h
//  Pods
//
//  Created by liubiao on 15/11/2.
//
//

#import <Foundation/Foundation.h>
/*!
 *  @brief  数据变化回调blcok
 *
 *  @param baseStore   数据的store
 *  @param dataChanged 数据变化详情
 *
 *  @return
 */
typedef  void(^ALObserverDistributeBlock)(id msg,NSString *distributeIdentifier);

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


@end
