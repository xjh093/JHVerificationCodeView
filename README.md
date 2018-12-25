# JHVerificationCodeView
A single authentication code input box 
- 单个的验证码输入框

---

# Version
Latest release version: 
- [1.3.1](https://github.com/xjh093/JHVerificationCodeView/releases)

---

# Cocoapods

`pod "JHVerificationCodeView"`

---

# What

![image](https://github.com/xjh093/JHVerificationCodeView/blob/master/image.png)

---

# Usage

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

---

# Logs

### 2018-11-1:
1.add `underLineHighlightedColor`.
- 下划线高亮.

### 2018-10-17
1.add `FlickerAnimation`,`underline`.
- 光标动画，下划线.

### 2018-10-15
1.add `inputBoxCornerRadius`,`inputBoxHighlightedColor`,and `autoShowKeyboard`.
- 输入框圆角，输入框高亮，自动显示键盘.

### 2018-10-11
1.add `inputType`.
- 输入类型限制.

### 2018-6-25
1.add `secureTextEntry`.
- 密文模式.

### 2018-4-19:
1.`inputBoxSpacing` can be negative. 
- 输入框间隔可设置成负数，让输入框连在一起.

### 2017-8-25:
1.upload. 
- 上传.

---

# More detail in Demo :)
