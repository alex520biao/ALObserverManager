//
//  ALDataStore.h
//  ALObserverManager
//
//  Created by liubiao on 15/11/6.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALObserverManager/ALObserverManager.h>

/*!
 *  @brief ALDataStore定义的消息类型
 */
typedef NS_ENUM(NSInteger, ALDataStoreMsgType) {
    /*!
     *   A类型消息
     */
    ALDataStoreMsgType_A,
    /*!
     *  B类型消息
     */
    ALDataStoreMsgType_B,
    /*!
     *  C类型消息
     */
    ALDataStoreMsgType_C
};

/*!
 *  @brief  数据管理者: 管理数据变化并将数据变化消息发送给所有的监听者
 */
@interface ALDataStore : NSObject

+(instancetype) sharedInstance;

/*!
 *  @brief  注册消息
 *
 *  @param observer
 *  @param type
 *  @param responseBlock        
 */
- (void)addObserver:(id)observer
               type:(ALDataStoreMsgType)type
      responseBlock:(ALObserverDistributeBlock)responseBlock;

- (void)sendMessage:(id)msg type:(ALDataStoreMsgType)type;

#pragma mark - test
-(void)testMessageType_A;
-(void)testMessageType_B;
-(void)testMessageType_C;

@end
