//
//  ALDataStore.m
//  ALObserverManager
//
//  Created by liubiao on 15/11/6.
//  Copyright © 2015年 alex520biao. All rights reserved.
//

#import "ALDataStore.h"

@interface ALDataStore ()

/*!
 *  @brief  订阅/发布管理器
 */
@property(nonatomic,strong)ALObserverManager *observerManager;

@end

@implementation ALDataStore

//实现代码
+ (instancetype) sharedInstance{
    static ALDataStore * __sharedInstance = nil;
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
 *  @param responseBlock
 */
- (void)addObserver:(id)observer
               type:(ALDataStoreMsgType)type
      responseBlock:(ALObserverDistributeBlock)responseBlock{

    NSString * distributeIdentifier = [ALDataStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }
    
    [self.observerManager addObserver:observer
                           distribute:distributeIdentifier
                        responseBlock:responseBlock];
}

- (void)sendMessage:(id)msg type:(ALDataStoreMsgType)type{
    NSString * distributeIdentifier = [ALDataStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }

    [self.observerManager sendMessage:msg distribute:distributeIdentifier];
}


+(NSString*)distributeIdentifierWithType:(ALDataStoreMsgType)type{
    NSString * distributeIdentifier = nil;
    if(type == ALDataStoreMsgType_A){
        distributeIdentifier = @"ALDataStoreMsgType_A";
    }else if (type == ALDataStoreMsgType_B){
        distributeIdentifier = @"ALDataStoreMsgType_B";
    }else if (type == ALDataStoreMsgType_C){
        distributeIdentifier = @"ALDataStoreMsgType_C";
    }
    return distributeIdentifier;
}

@end
