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

#define kFlickerAnimation @"kFlickerAnimation"

@implementation JHVCConfig

- (instancetype)init{
    if (self = [super init]) {
        _inputBoxBorderWidth = 1.0/[UIScreen mainScreen].scale;
        _inputBoxSpacing = 5;
        _inputBoxColor = [UIColor lightGrayColor];
        _tintColor = [UIColor blueColor];
        _showFlickerAnimation = YES;
        _underLineColor = [UIColor lightGrayColor];
    }
    return self;
}

@end

@interface JHVerificationCodeView()
@property (strong,  nonatomic) JHVCConfig               *config;
@property (strong,  nonatomic) UITextView               *textView;
@end

@implementation JHVerificationCodeView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    
    if (_config.showUnderLine) {
        if (_config.underLineSize.width <= 0) {
            CGSize size = _config.underLineSize;
            size.width = inputBoxWidth;
            _config.underLineSize = size;
        }
        if (_config.underLineSize.height <= 0) {
            CGSize size = _config.underLineSize;
            size.height = 1;
            _config.underLineSize = size;
        }
    }
    
    for (int i = 0; i < _config.inputBoxNumber; ++i) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(_config.leftMargin+(inputBoxWidth+inputBoxSpacing)*i, (CGRectGetHeight(frame)-inputBoxHeight)*0.5, inputBoxWidth, inputBoxHeight);
        textField.textAlignment = 1;
        if (_config.inputBoxBorderWidth) {
            textField.layer.borderWidth = _config.inputBoxBorderWidth;
        }
        if (_config.inputBoxCornerRadius) {
            textField.layer.cornerRadius = _config.inputBoxCornerRadius;
        }
        if (_config.inputBoxColor) {
            textField.layer.borderColor = _config.inputBoxColor.CGColor;
        }
        if (_config.tintColor) {
            if (inputBoxWidth > 2 && inputBoxHeight > 8) {
                CGFloat w = 2, y = 4, x = (inputBoxWidth-w)/2, h = inputBoxHeight-2*y;
                [textField.layer addSublayer:({
                    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x,y,w,h)];
                    CAShapeLayer *layer = [CAShapeLayer layer];
                    layer.path = path.CGPath;
                    layer.fillColor = _config.tintColor.CGColor;
                    [layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
                    if (i != 0) {
                        layer.hidden = YES;
                    }
                    layer;
                })];
            }
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
        if (_config.showUnderLine) {
            CGFloat x = (inputBoxWidth-_config.underLineSize.width)/2.0;
            CGFloat y = (inputBoxHeight-_config.underLineSize.height);
            CGRect frame = CGRectMake(x, y, _config.underLineSize.width, _config.underLineSize.height);
            
            UIView *underLine = [[UIView alloc] init];
            underLine.tag = 100;
            underLine.frame = frame;
            underLine.backgroundColor = _config.underLineColor;
            [textField addSubview:underLine];
            
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
    _textView.secureTextEntry = _config.useSystemPasswordKeyboard;
    _textView.keyboardType = _config.keyboardType;
    [self addSubview:_textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_textChange:) name:UITextViewTextDidChangeNotification object:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    if (_config.autoShowKeyboard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_textView becomeFirstResponder];
        });
    }
}

- (CABasicAnimation *)xx_alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    alpha.duration = 1.0;
    alpha.repeatCount = CGFLOAT_MAX;
    alpha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return alpha;
}

- (void)xx_tap{
    [_textView becomeFirstResponder];
}

- (void)xx_didBecomeActive{
    // restart Flicker Animation
    if (_config.showFlickerAnimation && _textView.text.length < self.subviews.count) {
        UITextField *textField = self.subviews[_textView.text.length];
        CALayer *layer = textField.layer.sublayers[0];
        [layer removeAnimationForKey:kFlickerAnimation];
        [layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
    }
}

- (void)xx_textChange:(NSNotification *)noti
{
    //NSLog(@"%@",noti.object);
    if (_textView != noti.object) {
        return;
    }
    
    NSInteger count = _config.inputBoxNumber;
    
    // set default
    for (int i = 0; i < count; ++i) {
        UITextField *textField = self.subviews[i];
        textField.text = @"";
        
        if (_config.inputBoxColor) {
            textField.layer.borderColor = _config.inputBoxColor.CGColor;
        }
        if (_config.showFlickerAnimation) {
            CALayer *layer = textField.layer.sublayers[0];
            layer.hidden = YES;
            [layer removeAnimationForKey:kFlickerAnimation];
        }
        if (_config.showUnderLine) {
            UIView *underLine = [textField viewWithTag:100];
            underLine.backgroundColor = _config.underLineColor;
        }
    }
    
    // trim space
    NSString *text = [_textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // number & alphabet
    NSMutableString *mstr = @"".mutableCopy;
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        if (_config.inputType == JHVCConfigInputType_Number_Alphabet) {
            if ((c >= '0' && c <= '9') ||
                (c >= 'A' && c <= 'Z') ||
                (c >= 'a' && c <= 'z')) {
                [mstr appendFormat:@"%c",c];
            }
        }else if (_config.inputType == JHVCConfigInputType_Number) {
            if ((c >= '0' && c <= '9')) {
                [mstr appendFormat:@"%c",c];
            }
        }else if (_config.inputType == JHVCConfigInputType_Alphabet) {
            if ((c >= 'A' && c <= 'Z') ||
                (c >= 'a' && c <= 'z')) {
                [mstr appendFormat:@"%c",c];
            }
        }
    }
    
    text = mstr;
    if (text.length > count) {
        text = [text substringToIndex:count];
    }
    _textView.text = text;
    if (_inputBlock) {
        _inputBlock(text);
    }
    
    //NSLog(@"%@",text);
    
    // set value
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        UITextField *textField = self.subviews[i];
        textField.text = [NSString stringWithFormat:@"%c",c];
        if (!textField.secureTextEntry && _config.customInputHolder.length > 0) {
            textField.text = _config.customInputHolder;
        }
        
        if (_config.inputBoxHighlightedColor) {
            textField.layer.borderColor = _config.inputBoxHighlightedColor.CGColor;
        }
      
        if (_config.showUnderLine && _config.underLineHighlightedColor) {
            UIView *underLine = [textField viewWithTag:100];
            underLine.backgroundColor = _config.underLineHighlightedColor;
        }
    }
    
    // Flicker Animation
    if (_config.showFlickerAnimation && text.length < self.subviews.count) {
        UITextField *textField = self.subviews[text.length];
        CALayer *layer = textField.layer.sublayers[0];
        layer.hidden = NO;
        [layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
    }
    
    if (text.length == count) {
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

#pragma mark - public

- (void)clear
{
    _textView.text = @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:_textView];
}

@end
