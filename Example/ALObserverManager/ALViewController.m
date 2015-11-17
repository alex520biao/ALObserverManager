//
//  ALViewController.m
//  ALObserverManager
//
//  Created by alex520biao on 11/06/2015.
//  Copyright (c) 2014 alex520biao. All rights reserved.
//

#import "ALViewController.h"
#import "ALDataStore.h"
#import "ALNewStore.h"
#import "ALNewStoreDelegate.h"

@interface ALViewController ()<ALNewStoreDelegate>


@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //ALViewController向ALDataStore注册监听消息
    [[ALDataStore sharedInstance] addObserver:self
                                         type:ALDataStoreMsgType_A
                                responseBlock:^(ALDataStore *sender, NSString *msg, NSDictionary *userInfo) {
                                    NSLog(@"接收消息: %@",msg);
                                }];
    
    [[ALDataStore sharedInstance] addObserver:self
                                         type:ALDataStoreMsgType_B
                                responseBlock:^(ALDataStore *sender, NSString *msg, NSDictionary *userInfo) {
                                    NSLog(@"接收消息: %@",msg);
                                }];

    
    //发送ALDataStoreMsgType类型测试消息
    [[ALDataStore sharedInstance] testMessageType_A];
    [[ALDataStore sharedInstance] testMessageType_B];
    
    [[ALNewStore sharedInstance] addObserver:self
                                        type:ALNewStoreMsgType_A];
    
    [[ALNewStore sharedInstance] testMessageType_A];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ALNewStoreDelegate
/*!
 *  @brief  ALNewStore发送消息协议
 *
 *  @param sender ALNewStore
 *  @param msg    消息体
 */
-(void)newStore:(ALObserverMsg *)msg{

}

@end
