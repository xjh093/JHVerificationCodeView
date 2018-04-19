//
//  JHVerificationCodeView.m
//  JHKit
//
//  Created by HaoCold on 2017/8/21.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHVerificationCodeView.h"

@implementation JHVCConfig

- (instancetype)init{
    if (self = [super init]) {
        _inputBoxSpacing = 5;
    }
    return self;
}

@end

@interface JHVerificationCodeView()
@property (strong,  nonatomic) JHVCConfig               *config;
@property (strong,  nonatomic) UITextView               *textView;
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
    
    //优先考虑 inputBoxWidth
    CGFloat inputBoxSpacing = _config.inputBoxSpacing;
    
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
        textField.userInteractionEnabled = NO;
        [self addSubview:textField];
    }
    
    [self addGestureRecognizer:({
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xx_tap)];
    })];
    
    _textView = [[UITextView alloc] init];
    _textView.frame = CGRectMake(0, CGRectGetHeight(frame), 0, 0);
    [self addSubview:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:_textView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_textView becomeFirstResponder];
    });
}

- (void)xx_tap{
    [_textView becomeFirstResponder];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange
{
    if (_textView != noti.object) {
        return;
    }
    
    //去空格
    NSString *text = [_textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //保留数字和字母
    NSMutableString *mstr = @"".mutableCopy;
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        if ((c >= '0' && c <= '9') ||
            (c >= 'A' && c <= 'Z') ||
            (c >= 'a' && c <= 'z')) {
            [mstr appendFormat:@"%c",c];
        }
    }
    
    text = mstr;
    if (text.length > 6) {
        text = [text substringToIndex:6];
    }
    _textView.text = text;
    
    NSLog(@"%@",text);
    
    for (int i = 0; i < 6; ++i) {
        UITextField *textField = self.subviews[i];
        textField.text = @"";
    }
    
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        UITextField *textField = self.subviews[i];
        textField.text = [NSString stringWithFormat:@"%c",c];
    }
    
    if (text.length == 6) {
        [self xx_finish];
    }
}

- (void)xx_finish
{
    if (_finishBlock) {
        _finishBlock(_textView.text);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endEditing:YES];
    });
}

@end
