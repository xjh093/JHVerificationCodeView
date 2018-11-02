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
    // example 1
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 120, kScreenWidth, 30);
        label.textAlignment = 1;
        label.text = @"InputType: Number & Alphabet";
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
        config.textColor       = [UIColor blueColor];
        config.inputType       = JHVCConfigInputType_Number_Alphabet;
        
        config.inputBoxBorderWidth  = 1;
        config.inputBoxCornerRadius = 5;
        
        
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 180, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 150, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(NSString *code) {
                label.text = code;
            };
            codeView;
        })];
    }

    // example 2
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 210, kScreenWidth, 30);
        label.textAlignment = 1;
        label.text = @"InputType: Number";
        [self.view addSubview:label];
        
        JHVCConfig *config     = [[JHVCConfig alloc] init];
        config.inputBoxNumber  = 6;
        config.inputBoxSpacing = 5;
        config.inputBoxWidth   = 33;
        config.inputBoxHeight  = 28;
        config.tintColor       = [UIColor greenColor];
        config.secureTextEntry = NO;
        config.inputBoxColor   = [UIColor brownColor];
        config.font            = [UIFont boldSystemFontOfSize:16];
        config.textColor       = [UIColor cyanColor];
        config.inputType       = JHVCConfigInputType_Number;
        
        config.inputBoxBorderWidth  = 1;
        config.inputBoxHighlightedColor = [UIColor purpleColor];
        
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 270, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 240, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(NSString *code) {
                label.text = code;
            };
            codeView;
        })];
    }
    
    // example 3
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 300, kScreenWidth, 30);
        label.textAlignment = 1;
        label.text = @"InputType: Alphabet";
        [self.view addSubview:label];
        
        JHVCConfig *config     = [[JHVCConfig alloc] init];
        config.inputBoxNumber  = 6;
        config.inputBoxSpacing = -1;
        config.inputBoxWidth   = 33;
        config.inputBoxHeight  = 28;
        config.tintColor       = [UIColor redColor];
        config.secureTextEntry = YES;
        config.inputBoxColor   = [UIColor brownColor];
        config.font            = [UIFont boldSystemFontOfSize:16];
        config.textColor       = [UIColor grayColor];
        config.inputType       = JHVCConfigInputType_Alphabet;
        
        config.inputBoxBorderWidth  = 1;
        
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 360, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 330, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(NSString *code) {
                label.text = code;
            };
            codeView;
        })];
    }
    
    // example 4
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 390, kScreenWidth, 30);
        label.textAlignment = 1;
        label.text = @"InputType: Alphabet";
        [self.view addSubview:label];
        
        JHVCConfig *config     = [[JHVCConfig alloc] init];
        config.inputBoxNumber  = 4;
        config.inputBoxSpacing = 4;
        config.inputBoxWidth   = 33;
        config.inputBoxHeight  = 28;
        config.tintColor       = [UIColor blueColor];
        config.secureTextEntry = YES;
        config.inputBoxColor   = [UIColor clearColor];
        config.font            = [UIFont boldSystemFontOfSize:16];
        config.textColor       = [UIColor grayColor];
        config.inputType       = JHVCConfigInputType_Alphabet;
        
        config.inputBoxBorderWidth  = 1;
        config.showUnderLine = YES;
        config.underLineSize = CGSizeMake(33, 2);
        config.underLineColor = [UIColor brownColor];
        config.underLineHighlightedColor = [UIColor redColor];
        
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 450, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 420, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(NSString *code) {
                label.text = code;
            };
            codeView;
        })];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
