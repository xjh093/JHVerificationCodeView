//
//  JHVerificationCodeView.m
//  JHKit
//
//  Created by HaoCold on 2017/8/21.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHVerificationCodeView.h"

@implementation JHVCConfig @end

@interface JHVerificationCodeView()<UITextFieldDelegate>
@property (strong,  nonatomic) JHVCConfig               *config;
@property (strong,  nonatomic) NSMutableDictionary      *textFieldDic;
@end

@implementation JHVerificationCodeView

- (instancetype)initWithFrame:(CGRect)frame config:(JHVCConfig *)config{
    if (self = [super initWithFrame:frame]) {
        _config = config;
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)jhSetupViews:(CGRect)frame
{
    if (frame.size.width <= 0 ||
        frame.size.height <= 0 ||
        _config.inputBoxNumber == 0 ||
        _config.inputBoxWidth > frame.size.width) {
        return;
    }
    
    _textFieldDic = @{}.mutableCopy;
    
    //优先考虑 inputBoxWidth
    CGFloat inputBoxSpacing = 5;
    if (_config.inputBoxSpacing > 0) {
        inputBoxSpacing = _config.inputBoxSpacing;
    }
    
    CGFloat inputBoxWidth = 0;
    if (_config.inputBoxWidth > 0) {
        inputBoxWidth = _config.inputBoxWidth;
    }
    
    CGFloat leftMargin = 0;
    if (inputBoxWidth > 0) {
        _config.leftMargin = (CGRectGetWidth(frame)-inputBoxWidth*_config.inputBoxNumber-inputBoxSpacing*(_config.inputBoxNumber-1))*0.5;
        leftMargin = _config.leftMargin;
    }else{
        _config.inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
        inputBoxWidth = _config.inputBoxWidth;
    }
    
    if (_config.leftMargin < 0) {
        _config.leftMargin = 0;
        _config.inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
        
        leftMargin = _config.leftMargin;
        inputBoxWidth = _config.inputBoxWidth;
    }
    
    CGFloat inputBoxHeight = 0;
    if (_config.inputBoxHeight > CGRectGetHeight(frame)) {
        _config.inputBoxHeight = CGRectGetHeight(frame);
    }
    inputBoxHeight = _config.inputBoxHeight;
    
    for (int i = 0; i < _config.inputBoxNumber; ++i) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(_config.leftMargin+(inputBoxWidth+inputBoxSpacing)*i, (CGRectGetHeight(frame)-inputBoxHeight)*0.5, inputBoxWidth, inputBoxHeight);
        textField.textAlignment = 1;
        textField.layer.borderWidth = 0.5;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        if (_config.inputBoxBorderWidth) {
            textField.layer.borderWidth = _config.inputBoxBorderWidth;
        }
        if (_config.inputBoxColor) {
            textField.layer.borderColor = _config.inputBoxColor.CGColor;
        }
        if (_config.tintColor) {
            textField.tintColor = _config.tintColor;
        }
        if (_config.secureTextEntry) {
            textField.secureTextEntry = _config.secureTextEntry;
        }
        if (_config.font){
            textField.font = _config.font;
        }
        if (_config.textColor) {
            textField.textColor = _config.textColor;
        }
        
        textField.tag = i;
        textField.delegate = self;
        [self addSubview:textField];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITextField *xxTextField = self.subviews[0];
        [xxTextField becomeFirstResponder];
    });
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"textField.text:%@,string:%@",textField.text,string);
    
    [_textFieldDic setObject:string forKey:@(textField.tag)];
    
    //输入后光标往后移
    if (textField.text.length == 0 && string.length == 1) {
        for (NSInteger i = textField.tag + 1; i < self.subviews.count; ++i) {
            UITextField *xxTextField = self.subviews[i];
            if (xxTextField.text.length == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [xxTextField becomeFirstResponder];
                });
                break;
            }
        }
    }
    //删除后光标往前移
    else if (textField.text.length == 0 && string.length == 0){
        BOOL flag = NO;
        if (textField.tag + 1 < self.subviews.count) { //后一个输入框
            UITextField *xxTextField = self.subviews[textField.tag+1];
            if (xxTextField.text.length == 0) { //没有内容
                flag = YES;
            }
        }else{ //是最后一个输入框
            flag = YES;
        }
        
        //如果它后面的输入框有数字，则不前移
        //如果要前移，则设置 flag = YES;
        flag = YES;
        
        //前移情况
        if (textField.tag - 1 >= 0 && flag) {
            UITextField *xxTextField = self.subviews[textField.tag-1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [xxTextField becomeFirstResponder];
                xxTextField.text = @"";
            });
        }
    }else if (textField.text.length > 0 && string.length == 1){
        //超过1位，截取最新的，光标后移
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            textField.text = string;
            
            for (NSInteger i = textField.tag + 1; i < self.subviews.count; ++i) {
                UITextField *xxTextField = self.subviews[i];
                if (xxTextField.text.length == 0) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [xxTextField becomeFirstResponder];
                    });
                    break;
                }
            }
        });
    }
    
    NSArray *array = _textFieldDic.allValues;
    if (array.count < _config.inputBoxNumber || [array containsObject:@""]) {
        NSLog(@"NO");
    }else{
        NSLog(@"YES");
        [self xx_finish];
    }
    
    return YES;
}

- (void)xx_finish
{
    NSMutableString *mstr = @"".mutableCopy;
    for (int i = 0; i < _config.inputBoxNumber; ++i) {
        [mstr appendString:_textFieldDic[@(i)]];
    }
    
    if (_finishBlock) {
        _finishBlock(mstr);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endEditing:YES];
    });
    
    NSLog(@"code:%@",mstr);
}
@end
