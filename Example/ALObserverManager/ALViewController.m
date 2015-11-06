//
//  ALViewController.m
//  ALObserverManager
//
//  Created by alex520biao on 11/06/2015.
//  Copyright (c) 2014 alex520biao. All rights reserved.
//

#import "ALViewController.h"
#import "ALDataStore.h"

@interface ALViewController ()


@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //ALViewController向ALDataStore注册监听消息
    [[ALDataStore sharedInstance] addObserver:self
                                         type:ALDataStoreMsgType_A
                                responseBlock:^(id msg, NSString *distributeIdentifier) {
                                    NSString *message = (NSString*)msg;
                                    NSLog(@"接收消息: %@",message);
                                }];
    
    [[ALDataStore sharedInstance] addObserver:self
                                         type:ALDataStoreMsgType_B
                                responseBlock:^(id msg, NSString *distributeIdentifier) {
                                    NSString *message = (NSString*)msg;
                                    NSLog(@"接收消息: %@",message);
                                }];

    
    //发送ALDataStoreMsgType类型测试消息
    [[ALDataStore sharedInstance] sendMessage:@"你有新的A消息！！！" type:ALDataStoreMsgType_A];
    [[ALDataStore sharedInstance] sendMessage:@"你有新的B消息！！！" type:ALDataStoreMsgType_B];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
