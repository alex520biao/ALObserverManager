//
//  ObserverItem.h
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
typedef  void(^ObserverDistributeBlock)(id msg,NSString *distributeIdentifier);

@interface ObserverItem : NSObject

/*!
 *  @brief  消息分发唯一标识符
 */
@property (nonatomic, copy) NSString *distributeIdentifier;


/*!
 *  @brief  observer的地址
 */
@property (nonatomic, copy) NSString *observerAddress;

/*!
 *  @brief  数据变化时事件变化block
 */
@property (nonatomic, copy) ObserverDistributeBlock block;


@end
