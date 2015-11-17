//
//  ALNewStore.m
//  ALObserverManager
//
//  Created by liubiao on 15/11/8.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import "ALNewStore.h"

@interface ALNewStore ()

/*!
 *  @brief  订阅/发布管理器
 */
@property(nonatomic,strong)ALObserverManager *observerManager;

@end

@implementation ALNewStore

//实现代码
+ (instancetype) sharedInstance{
    static ALNewStore * __sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    return __sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_observerManager) {
            _observerManager = [[ALObserverManager alloc] init];
        }
    }
    return self;
}

/*!
 *  @brief  注册消息
 *
 *  @param observer
 *  @param type
 */
- (void)addObserver:(id<ALNewStoreDelegate>)observer
               type:(ALNewStoreMsgType)type{
    NSString * distributeIdentifier = [ALNewStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }
    
    [self.observerManager addObserver:observer
                           distribute:distributeIdentifier
                             userInfo:nil
                             selector:@selector(newStore:)];
}

- (void)sendMessage:(id)msg type:(ALNewStoreMsgType)type{
    NSString * distributeIdentifier = [ALNewStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }
    
    [self.observerManager postMessage:msg sender:self distribute:distributeIdentifier];
}


+(NSString*)distributeIdentifierWithType:(ALNewStoreMsgType)type{
    NSString * distributeIdentifier = nil;
    if(type == ALNewStoreMsgType_A){
        distributeIdentifier = @"ALNewStoreMsgType_A";
    }else if (type == ALNewStoreMsgType_B){
        distributeIdentifier = @"ALNewStoreMsgType_B";
    }else if (type == ALNewStoreMsgType_C){
        distributeIdentifier = @"ALNewStoreMsgType_C";
    }
    return distributeIdentifier;
}

#pragma mark - test
-(void)testMessageType_A{
    [self sendMessage:@"新消息ALNewStoreMsgType_A" type:ALNewStoreMsgType_A];
}

@end
