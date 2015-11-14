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
 *  @brief  消息identifier
 */
@property (nonatomic, copy) NSString *distributeIdentifier;

/*!
 *  @brief  消息内容
 */
@property (nonatomic, strong) id payload;

@end
