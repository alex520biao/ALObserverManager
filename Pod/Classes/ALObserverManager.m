//
//  ALObserverManager.m
//  Pods
//
//  Created by liubiao on 15/11/2.
//
//

#import "ALObserverManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ALObserverItem.h"

@interface ALObserverManager()

/*!
 *  @brief  监听项集合
 */
@property(nonatomic,strong)NSMutableDictionary *observerItemDict;

@end

@implementation ALObserverManager

- (void)dealloc {
    _observerItemDict = nil;
}

/*!
 *  @brief  通过distributeIdentifier发送消息,所有注册过distributeIdentifier的监听者都会收到消息
 */
- (void)sendMessage:(id)msg distribute:(NSString*)distributeIdentifier{
    [self.observerItemDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        NSDictionary *dict = obj;
        ALObserverItem *item = (ALObserverItem*)[dict objectForKey:distributeIdentifier];
        if (item && item.block) {
            item.block(msg,item.distributeIdentifier);
        }
    }];
}

#pragma mark - observer
- (void)addObserver:(id)observer
         distribute:(NSString*)distributeIdentifier
      responseBlock:(ALObserverDistributeBlock)responseBlock{

    //add observer
    NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
    [self addObserverWithAddress:observerAddress
                      distribute:distributeIdentifier
                   responseBlock:responseBlock];
    
    //remove observer when observer dealloc
    __weak typeof(self) weakSelf = self;
    [[observer rac_willDeallocSignal]subscribeCompleted:^{
        [weakSelf removeObserverWithAddress:observerAddress];
    }];
}

/*!
 *  @brief  移除监听者
 *
 *  @param observer
 */
- (void)removeObserver:(id)observer{
    if (observer) {
        NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
        if (observerAddress) {
            [self removeObserverWithAddress:observerAddress];
        }
    }
}


#pragma mark - internal method
- (void)addObserverWithAddress:(NSString *)observer_address
                    distribute:(NSString*)distributeIdentifier
                 responseBlock:(ALObserverDistributeBlock)responseBlock {
    if (observer_address && observer_address && responseBlock) {
        ALObserverItem *item = [[ALObserverItem alloc] init];
        item.distributeIdentifier = distributeIdentifier;
        item.observerAddress      = observer_address;
        item.block                = responseBlock;
        
        //以observerAddress为key,不存在则添加,存在则更新
        if(item && item.observerAddress){
            //获取distributeIdentifier对应的项目
            NSMutableDictionary *observerDict = [self.observerItemDict objectForKey:item.observerAddress];
            if (!observerDict) {
                [self.observerItemDict setObject:[NSMutableDictionary dictionary] forKey:item.observerAddress];
                observerDict = [self.observerItemDict objectForKey:item.observerAddress];
            }
            
            //存放数据
            [observerDict setObject:item forKey:item.distributeIdentifier];
        }
    }
}

/*!
 *  @brief  移除指定监听者
 *
 *  @param observer_address
 */
- (void)removeObserverWithAddress:(NSString *)observer_address {
    if (observer_address) {
        [self.observerItemDict removeObjectForKey:observer_address];
    }
}

#pragma mark - lazy load
/*!
 *  @brief  当前所有监听者集合
 *
 *  @return
 */
-(NSMutableDictionary*)observerItemDict{
    if (!_observerItemDict) {
        _observerItemDict = [NSMutableDictionary dictionary];
    }
    return _observerItemDict;
}

@end
