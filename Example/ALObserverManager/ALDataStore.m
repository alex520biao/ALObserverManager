//
//  ALDataStore.m
//  ALObserverManager
//
//  Created by alex520biao on 15/11/6.
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
      responseBlock:(ALDataStoreDistributeBlock)responseBlock{

    NSString * distributeIdentifier = [ALDataStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"userValue" forKey:@"userKey"];
    [self.observerManager addObserver:observer
                           distribute:distributeIdentifier
                             userInfo:dict
                        responseBlock:^(id sender, ALObserverMsg *msg) {
                            if (responseBlock) {
                                responseBlock(sender,msg.payload,msg.userInfo);
                            }
                        }];
}

- (void)sendMessage:(NSString*)msg type:(ALDataStoreMsgType)type{
    NSString * distributeIdentifier = [ALDataStore distributeIdentifierWithType:type];
    if(!distributeIdentifier){
        return;
    }

    [self.observerManager postMessage:msg sender:self distribute:distributeIdentifier];
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

#pragma mark - test
-(void)testMessageType_A{
    [self sendMessage:@"你有新的A消息！！！" type:ALDataStoreMsgType_A];
}

-(void)testMessageType_B{
    [self sendMessage:@"你有新的B消息！！！" type:ALDataStoreMsgType_B];
}

-(void)testMessageType_C{
    [self sendMessage:@"你有新的C消息！！！" type:ALDataStoreMsgType_C];
}

@end
