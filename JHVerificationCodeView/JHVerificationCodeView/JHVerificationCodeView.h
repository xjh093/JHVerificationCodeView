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

//  version: 1.3.8
//  date: 2024-05-11

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JHVCConfigInputType) {
    JHVCConfigInputType_Number_Alphabet,
    JHVCConfigInputType_Number,
    JHVCConfigInputType_Alphabet,
};

@interface JHVCConfig : NSObject

//============================ Initialization ============================

///输入框个数
@property (assign,  nonatomic) NSInteger        inputBoxNumber;
///单个输入框的宽度
@property (assign,  nonatomic) CGFloat          inputBoxWidth;
///单个输入框的高度
@property (assign,  nonatomic) CGFloat          inputBoxHeight;
///单个输入框的边框宽度, Default is 1 pixel
@property (assign,  nonatomic) CGFloat          inputBoxBorderWidth;
///单个输入框的边框圆角
@property (assign,  nonatomic) CGFloat          inputBoxCornerRadius;
///输入框间距, Default is 5
@property (assign,  nonatomic) CGFloat          inputBoxSpacing;
///左边距
@property (assign,  nonatomic) CGFloat          leftMargin;
///单个输入框的颜色, Default is lightGrayColor
@property (strong,  nonatomic) UIColor          *inputBoxColor;
///光标颜色, Default is blueColor
@property (strong,  nonatomic) UIColor          *tintColor;
///显示 或 隐藏
@property (assign,  nonatomic) BOOL             secureTextEntry;
///字体, Default is [UIFont boldSystemFontOfSize:16]
@property (strong,  nonatomic) UIFont           *font;
///颜色, Default is [UIColor blackColor]
@property (strong,  nonatomic) UIColor          *textColor;
///输入类型：数字+字母，数字，字母. Default is 'JHVCConfigInputType_Number_Alphabet'
@property (nonatomic,  assign) JHVCConfigInputType  inputType;
///自动弹出键盘
@property (nonatomic,  assign) BOOL             autoShowKeyboard;
///默认0.5
@property (nonatomic,  assign) CGFloat          autoShowKeyboardDelay;
///光标闪烁动画, Default is YES
@property (nonatomic,  assign) BOOL             showFlickerAnimation;
///显示下划线
@property (nonatomic,  assign) BOOL             showUnderLine;
///下划线尺寸
@property (nonatomic,  assign) CGSize           underLineSize;
///下划线颜色, Default is lightGrayColor
@property (nonatomic,  strong) UIColor          *underLineColor;
///自定义的输入占位字符，secureTextEntry = NO，有效
@property (nonatomic,    copy) NSString         *customInputHolder;
///设置键盘类型
@property (nonatomic,  assign) UIKeyboardType   keyboardType;
///使用系统的密码键盘
@property (nonatomic,  assign) BOOL             useSystemPasswordKeyboard;

//============================ Input ============================

///单个输入框输入时的颜色
@property (strong,  nonatomic) UIColor          *inputBoxHighlightedColor;
///下划线高亮颜色
@property (nonatomic,  strong) UIColor          *underLineHighlightedColor;

//============================ Finish ============================
/* 输入完成后，可能根据不同的状态，显示不同的颜色。  */

///单个输入框输入时的颜色
@property (strong,  nonatomic) NSArray<UIColor*>    *inputBoxFinishColors;
///下划线高亮颜色
@property (nonatomic,  strong) NSArray<UIColor*>    *underLineFinishColors;
///输入完成时字体
@property (strong,  nonatomic) NSArray<UIFont*>     *finishFonts;
///输入完成时颜色
@property (strong,  nonatomic) NSArray<UIColor*>    *finishTextColors;

@end

@interface JHVerificationCodeView : UIView

@property (copy,    nonatomic) void (^inputBlock)(NSString *code);
@property (copy,    nonatomic) void (^finishBlock)(JHVerificationCodeView *codeView, NSString *code);

- (instancetype)initWithFrame:(CGRect)frame config:(JHVCConfig *)config;

/**
 清空所有输入
 */
- (void)clear;

/**
 输入完成后，调用此方法，根据 index 从 `Finish` 下的4个属性获取对应的值来设置颜色。
 
 @param index 用于从 `inputBoxFinishColors`、`underLineFinishColors`、`finishFonts`、`finishTextColors`中获取对应的值
 */
- (void)showInputFinishColorWithIndex:(NSUInteger)index;

@end
