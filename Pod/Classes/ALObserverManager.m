//
//  ALObserverManager.m
//  Pods
//
//  Created by alex520biao on 15/11/2.
//
//

#import "ALObserverManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ALObserverItem.h"
#import "ALObserverMsg.h"

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
 *  palyload即为ALObserverMsg的palyload
 */
- (void)postMessage:(id)palyload
             sender:(id)sender
         distribute:(NSString*)distributeIdentifier{
    
    [self.observerItemDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        NSDictionary *dict = obj;
        ALObserverItem *item = (ALObserverItem*)[dict objectForKey:distributeIdentifier];
        ALObserverMsg *message = [[ALObserverMsg alloc] init];
        message.sender  = sender;
        message.payload = palyload;
        message.distributeIdentifier = distributeIdentifier;
        message.userInfo = item.userInfo;
        //使用block回调
        if (item && item.block) {
            item.block(message.sender,message);
        }
        
        //使用SEL回调
        if(item && item.selStr){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            //NSString -- > SEL
            NSString *selStr = item.selStr;
            SEL sel = NSSelectorFromString(selStr);
            if ([item.observer respondsToSelector:sel]) {
                [item.observer performSelector:sel withObject:message];
            }
#pragma clang diagnostic pop
        }
    }];
}

#pragma mark - observer
- (void)addObserver:(id)observer
         distribute:(NSString*)distributeIdentifier
           userInfo:(NSDictionary *)userInfo
      responseBlock:(ALObserverDistributeBlock)responseBlock{

    //add observer
    [self addObserver:observer
           distribute:distributeIdentifier
             userInfo:userInfo
        responseBlock:responseBlock
             selector:nil];
    
    //remove observer when observer dealloc
    __weak typeof(self) weakSelf = self;
    NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
    [[observer rac_willDeallocSignal]subscribeCompleted:^{
        [weakSelf removeObserverWithAddress:observerAddress];
    }];
}

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
           selector:(SEL)sel{

    NSString *selStr = NSStringFromSelector(sel);
    //add observer
    [self addObserver:observer
           distribute:distributeIdentifier
             userInfo:userInfo
        responseBlock:nil
             selector:selStr];
    
    //remove observer when observer dealloc
    __weak typeof(self) weakSelf = self;
    NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
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

- (void)removeObserver:(id)observer distribute:(NSString*)distributeIdentifier{
    NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
    if (observerAddress && distributeIdentifier) {
        NSMutableDictionary *observerDict = [self.observerItemDict objectForKey:observerAddress];
        [observerDict removeObjectForKey:distributeIdentifier];
    }
}

#pragma mark - internal method
- (void)addObserver:(id)observer
         distribute:(NSString*)distributeIdentifier
           userInfo:(NSDictionary *)userInfo
      responseBlock:(ALObserverDistributeBlock)responseBlock
           selector:(NSString*)selStr{
    NSString *observerAddress = [NSString stringWithFormat:@"%p",observer];
    if (observerAddress && distributeIdentifier) {
        ALObserverItem *item = [[ALObserverItem alloc] init];
        item.observer             = observer;
        item.distributeIdentifier = distributeIdentifier;
        item.userInfo             = userInfo;
        item.block                = responseBlock;
        item.selStr               = selStr;
        
        //以observerAddress为key,不存在则添加,存在则更新
        if(item && observerAddress){
            //获取distributeIdentifier对应的项目
            NSMutableDictionary *observerDict = [self.observerItemDict objectForKey:observerAddress];
            if (!observerDict) {
                [self.observerItemDict setObject:[NSMutableDictionary dictionary] forKey:observerAddress];
                observerDict = [self.observerItemDict objectForKey:observerAddress];
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
