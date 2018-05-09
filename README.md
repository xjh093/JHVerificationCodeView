# JHVerificationCodeView
### A single authentication code input box & 单个的验证码输入框

---

## What is it?
![image](https://github.com/xjh093/JHVerificationCodeView/blob/master/123.png)

---

## Logs & 更新日志：

### 2018-4-19:
1.inputBoxSpacing can be negative. & 输入框间隔可设置成负数，让输入框连在一起.

### 2017-8-25:
1.upload. 

---

## Configuration:
输入框的配置：& The input field configuration:

```
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
@end
```

---

## Use:

简单地使用：& Simple to use:
```
    JHVCConfig *config     = [[JHVCConfig alloc] init];
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
        JHVerificationCodeView *codeView =
        [[JHVerificationCodeView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 30)
                                               config:config];
        codeView.finishBlock = ^(NSString *code) {
            label.text = code;
        };
        codeView;
    })];
```
