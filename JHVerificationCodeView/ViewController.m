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
    
    self.title = @"验证码输入框";
    
    [self jhSetupViews];
    
}

- (void)jhSetupViews
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 150, kScreenWidth, 30);
    label.textAlignment = 1;
    [self.view addSubview:label];
    
    JHVCConfig *config     = [[JHVCConfig alloc] init];
    config.inputBoxNumber  = 6; 
    config.inputBoxSpacing = 5;
    config.inputBoxWidth   = 33;
    config.inputBoxHeight  = 28;
    config.tintColor       = [UIColor blackColor];
    config.secureTextEntry = NO;
    config.inputBoxColor   = [UIColor brownColor];
    config.font            = [UIFont boldSystemFontOfSize:16];
    config.textColor       = [UIColor brownColor];
    config.inputType       = JHVCConfigInputType_Number_Alphabet;
    
    [self.view addSubview:({
        JHVerificationCodeView *codeView =
        [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 30)
                                               config:config];
        codeView.finishBlock = ^(NSString *code) {
            label.text = code;
        };
        codeView;
    })];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
