//
//  ALNewStoreDelegate.h
//  ALObserverManager
//
//  Created by liubiao on 15/11/8.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALNewStore;
@protocol ALNewStoreDelegate <NSObject>

/*!
 *  @brief  ALNewStore发送消息协议
 *
 *  @param sender ALNewStore
 *  @param msg    消息体
 */
-(void)store:(ALNewStore*)sender newStore:(NSString *)msg;

@end
