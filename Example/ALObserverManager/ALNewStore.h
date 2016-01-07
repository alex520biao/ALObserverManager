//
//  ALNewStore.h
//  ALObserverManager
//
//  Created by alex520biao on 15/11/8.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALObserverManager/ALObserverManager.h>
#import "ALNewStoreDelegate.h"
#import <ALObserverManager/ALObserverManager.h>

/*!
 *  @brief ALDataStore定义的消息类型
 */
typedef NS_ENUM(NSInteger, ALNewStoreMsgType) {
    /*!
     *   A类型消息
     */
    ALNewStoreMsgType_A,
    /*!
     *  B类型消息
     */
    ALNewStoreMsgType_B,
    /*!
     *  C类型消息
     */
    ALNewStoreMsgType_C
};

@interface ALNewStore : NSObject

+(instancetype) sharedInstance;

/*!
 *  @brief  注册消息
 *
 *  @param observer
 *  @param type
 */
- (void)addObserver:(id<ALNewStoreDelegate>)observer
               type:(ALNewStoreMsgType)type;

#pragma mark - test
-(void)testMessageType_A;

@end
