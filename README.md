# JHVerificationCodeView
### A single authentication code input box & 单个的验证码输入框

---

# Version
- Latest release version: [1.3.1](https://github.com/xjh093/JHVerificationCodeView/releases)

---

# What is it?
![image](https://github.com/xjh093/JHVerificationCodeView/blob/master/image.png)

---

# Logs & 更新日志：

### 2018-11-1:
1.add underLineHighlightedColor.

### 2018-10-17
1.add FlickerAnimation,underline

### 2018-10-15
1.add inputBoxCornerRadius,inputBoxHighlightedColor,add autoShowKeyboard.

### 2018-10-11
1.add inputType.

### 2018-6-25
1.add secureTextEntry.

### 2018-4-19:
1.inputBoxSpacing can be negative. & 输入框间隔可设置成负数，让输入框连在一起.

### 2017-8-25:
1.upload. 

---

# Usage:

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
    config.inputType       = JHVCConfigInputType_Number_Alphabet; // Default
    
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
