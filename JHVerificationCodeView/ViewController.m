//
//  ViewController.m
//  JHVerificationCodeView
//
//  Created by HaoCold on 2017/8/25.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHVerificationCodeView.h"
#import "NextViewController.h"


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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:@"清空" forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button sizeToFit];
        [button addTarget:self action:@selector(clearAction) forControlEvents:1<<6];
        button;
    })];
    
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithCustomView:({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:@"清空" forState:0];
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button sizeToFit];
            [button addTarget:self action:@selector(clearAction) forControlEvents:1<<6];
            button;
        })],
        [[UIBarButtonItem alloc] initWithCustomView:({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:@"跳转" forState:0];
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button sizeToFit];
            [button addTarget:self action:@selector(jumpAction) forControlEvents:1<<6];
            button;
        })]
    ];
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
    
        //config.customInputHolder = @"🔒";
    
        config.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        config.useSystemPasswordKeyboard = YES;
    
        config.inputBoxFinishColors = @[[UIColor redColor],[UIColor orangeColor]];
        config.finishFonts = @[[UIFont boldSystemFontOfSize:20],[UIFont systemFontOfSize:20]];
        config.finishTextColors = @[[UIColor greenColor],[UIColor orangeColor]];
    
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 180, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 150, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(JHVerificationCodeView *codeView, NSString *code) {
                label.text = code;
                
                // 根据最后输入结果，判断显示哪种颜色
                NSUInteger index = [code isEqualToString:@"123asd"] ? 1 : 0;
                [codeView showInputFinishColorWithIndex:index];
            };
            codeView.inputBlock = ^(NSString *code) {
                NSLog(@"example 1 code:%@",code);
            };
            codeView.tag = 100;
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
    
        config.customInputHolder = @"🈲";
    
        config.inputBoxFinishColors = @[[UIColor orangeColor],[UIColor redColor]];
        config.finishFonts = @[[UIFont boldSystemFontOfSize:20],[UIFont systemFontOfSize:20]];
        config.finishTextColors = @[[UIColor orangeColor],[UIColor greenColor]];
    
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 270, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 240, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(JHVerificationCodeView *codeView, NSString *code) {
                label.text = code;
                
                // 根据最后输入结果，判断显示哪种颜色
                NSUInteger index = [code isEqualToString:@"123456"] ? 1 : 0;
                [codeView showInputFinishColorWithIndex:index];
            };
            codeView.inputBlock = ^(NSString *code) {
                NSLog(@"example 2 code:%@",code);
            };
            codeView.tag = 200;
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
        config.secureTextEntry = NO;
        config.inputBoxColor   = [UIColor brownColor];
        config.font            = [UIFont boldSystemFontOfSize:16];
        config.textColor       = [UIColor grayColor];
        config.inputType       = JHVCConfigInputType_Alphabet;
        
        config.inputBoxBorderWidth  = 1;
    
        config.customInputHolder = @"❄️";
    
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 360, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 330, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(JHVerificationCodeView *codeView, NSString *code) {
                label.text = code;
            };
            codeView.inputBlock = ^(NSString *code) {
                NSLog(@"example 3 code:%@",code);
            };
            codeView.tag = 300;
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
        config.font            = [UIFont boldSystemFontOfSize:20];
        config.textColor       = [UIColor grayColor];
        config.inputType       = JHVCConfigInputType_Alphabet;
        
        config.inputBoxBorderWidth  = 1;
        config.showUnderLine = YES;
        config.underLineSize = CGSizeMake(33, 2);
        config.underLineColor = [UIColor brownColor];
        config.underLineHighlightedColor = [UIColor redColor];
    
        config.underLineFinishColors = @[[UIColor blueColor],[UIColor orangeColor]];
        config.finishFonts = @[[UIFont boldSystemFontOfSize:20],[UIFont systemFontOfSize:20]];
        config.finishTextColors = @[[UIColor greenColor],[UIColor orangeColor]];
    
        [self.view addSubview:({
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 450, kScreenWidth, 30);
            label.textAlignment = 1;
            [self.view addSubview:label];
            
            JHVerificationCodeView *codeView =
            [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 420, kScreenWidth-20, 30)
                                                   config:config];
            codeView.finishBlock = ^(JHVerificationCodeView *codeView, NSString *code) {
                label.text = code;
                
                // 根据最后输入结果，判断显示哪种颜色
                NSUInteger index = [code isEqualToString:@"Asdf"] ? 1 : 0;
                [codeView showInputFinishColorWithIndex:index];
            };
            codeView.inputBlock = ^(NSString *code) {
                NSLog(@"example 4 code:%@",code);
            };
            codeView.tag = 400;
            codeView;
        })];
    }
}


- (void)clearAction
{
    JHVerificationCodeView *codeView1 = [self.view viewWithTag:100];
    JHVerificationCodeView *codeView2 = [self.view viewWithTag:200];
    JHVerificationCodeView *codeView3 = [self.view viewWithTag:300];
    JHVerificationCodeView *codeView4 = [self.view viewWithTag:400];
    
    [codeView1 clear];
    [codeView2 clear];
    [codeView3 clear];
    [codeView4 clear];
    
}

- (void)jumpAction
{
    [self.navigationController pushViewController:[[NextViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
