//
//  JHVerificationCodeView.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JHVCConfigInputType) {
    JHVCConfigInputType_Number_Alphabet,
    JHVCConfigInputType_Number,
    JHVCConfigInputType_Alphabet,
};

@interface JHVCConfig : NSObject
///输入框个数
@property (assign,  nonatomic) NSInteger        inputBoxNumber;
///单个输入框的宽度
@property (assign,  nonatomic) CGFloat          inputBoxWidth;
///单个输入框的高度
@property (assign,  nonatomic) CGFloat          inputBoxHeight;
///单个输入框的边框宽度
@property (assign,  nonatomic) CGFloat          inputBoxBorderWidth;
///输入框间距
@property (assign,  nonatomic) CGFloat          inputBoxSpacing;
///左边距
@property (assign,  nonatomic) CGFloat          leftMargin;
///单个输入框的颜色
@property (strong,  nonatomic) UIColor          *inputBoxColor;
///光标颜色
@property (strong,  nonatomic) UIColor          *tintColor;
///显示 或 隐藏
@property (assign,  nonatomic) BOOL             secureTextEntry;
///字体
@property (strong,  nonatomic) UIFont           *font;
///颜色
@property (strong,  nonatomic) UIColor          *textColor;
///输入类型：数字+字母，数字，字母. Default is 'JHVCConfigInputType_Number_Alphabet'
@property (nonatomic,  assign) JHVCConfigInputType  inputType;
@end

@interface JHVerificationCodeView : UIView

@property (copy,    nonatomic) void (^finishBlock)(NSString *code);

- (instancetype)initWithFrame:(CGRect)frame config:(JHVCConfig *)config;

@end
