//
//  NextViewController.m
//  JHVerificationCodeView
//
//  Created by HaoCold on 2020/9/8.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "NextViewController.h"
#import "JHVerificationCodeView.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"自动弹出键盘";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
        // 自动弹出键盘
        config.autoShowKeyboard = YES;
        config.autoShowKeyboardDelay = 0.7;
    
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
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
