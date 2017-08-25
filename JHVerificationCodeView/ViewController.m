//
//  ViewController.m
//  JHVerificationCodeView
//
//  Created by HaoCold on 2017/8/25.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHVerificationCodeView.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"单个输入框的验证码";
    
    [self jhSetupViews];
    
}

- (void)jhSetupViews
{
    JHVCConfig *config = [[JHVCConfig alloc] init];
    config.inputBoxNumber  = 6; 
    config.inputBoxSpacing = 5;
    config.inputBoxWidth   = 33;
    config.inputBoxHeight  = 28;
    config.tintColor       = [UIColor blackColor];
    config.secureTextEntry = YES;
    config.inputBoxColor   = [UIColor brownColor];
    config.font            = [UIFont boldSystemFontOfSize:16];
    config.textColor       = [UIColor brownColor];
    
    [self.view addSubview:({
        [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 30)
                                               config:config];
    })];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
