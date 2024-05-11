# JHVerificationCodeView
A single authentication code input box 
- 单个的验证码输入框

---

# Version
Latest release version: 
- [1.3.7](https://github.com/xjh093/JHVerificationCodeView/releases)  ❌ out of date!

- download master version for use. (2024-05-11 15:06:24)

Swift version:
- [JHVerifyCodeView](https://github.com/xjh093/JHVerifyCodeView)

---

# Cocoapods

`pod "JHVerificationCodeView"`

---

# What

![image](https://github.com/xjh093/JHVerificationCodeView/blob/master/image.png)

![image](https://github.com/xjh093/JHVerificationCodeView/blob/master/image2.png)

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

- change log: [click here](https://github.com/xjh093/JHVerificationCodeView/blob/master/CHANGELOG.md)

---

# More detail in Demo :)
