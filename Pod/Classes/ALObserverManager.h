//
//  ALObserverManager.h
//  Pods
//
//  Created by liubiao on 15/11/2.
//
//

#import <Foundation/Foundation.h>
#import "ALObserverItem.h"
#import "ALObserverMsg.h"

/*!
 *  @brief  监听分发管理器
 */
@interface ALObserverManager : NSObject


#pragma mark - sendMessage

/*!
 *  @brief  通过distributeIdentifier发送消息,所有注册过distributeIdentifier的监听者都会收到消息
 */
- (void)postMessage:(id)msg sender:(id)sender distribute:(NSString*)distributeIdentifier;

#pragma mark - observer
/*!
 *  @brief  添加一个监听item: observer监听者添加distributeIdentifier监听
 *  @note   监听是自释放的,如果observer释放则监听自动解除
 *
 *  @param observer      监听者
 *  @param distributeIdentifier 本次监听的数据分发标识符
 *  @param userInfo     自定义数据
 *  @param responseBlock 监听者事件处理block
 */
- (void)addObserver:(id)observer
         distribute:(NSString*)distributeIdentifier
           userInfo:(NSDictionary *)userInfo
      responseBlock:(ALObserverDistributeBlock)responseBlock;

/*!
 *  @brief  监听distributeIdentifier标识的消息
 *
 *  @param observer             监听者
 *  @param distributeIdentifier 消息标识符
 *  @param userInfo 注册时保留的用户自定义数据
 *  @param sel                  消息分发方法observer的SEL
 */
- (void)addObserver:(id)observer
         distribute:(NSString*)distributeIdentifier
           userInfo:(NSDictionary *)userInfo
           selector:(SEL)sel;

/*!
 *  @brief  移除监听者所属的所有监听item
 *
 *  @param observer
 */
- (void)removeObserver:(id)observer;

- (void)removeObserver:(id)observer distribute:(NSString*)distributeIdentifier;

@end
