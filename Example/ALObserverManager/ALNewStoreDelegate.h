//
//  ALNewStoreDelegate.h
//  ALObserverManager
//
//  Created by alex520biao on 15/11/8.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALObserverManager/ALObserverManager.h>

@class ALNewStore;
@protocol ALNewStoreDelegate <NSObject>

/*!
 *  @brief  ALNewStore发送消息协议
 *
 *  @param msg    消息体
 */
-(void)newStore:(ALObserverMsg *)msg;

@end
