//
//  JobsAppDoorContentView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorContentView.h"
#import "JobsAppDoorConfig.h"

// 可以发现：（animateWithDuration + Masonry，动画参数设置无效）
// 用户名 和 密码 ，登录注册两个界面共用，只不过frame不一样
@interface JobsAppDoorContentView ()

@property(nonatomic,strong)UILabel *titleLab;//标题
@property(nonatomic,strong)UIButton *abandonLoginBtn;//随便逛逛按钮
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,strong)UIButton *sendBtn;//登录 & 注册按钮 （本页面请求可以不用jobsAppDoorContentViewBlock回调）
@property(nonatomic,strong)UIButton *storeCodeBtn;//记住密码
@property(nonatomic,strong)UIButton *findCodeBtn;//忘记密码

@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*loginDoorInputViewBaseStyleModelMutArr;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*registerDoorInputViewBaseStyleModelMutArr;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle_3 *>*inputViewMutArr;
@property(nonatomic,strong)NSMutableDictionary *loginInputTFValueMutDic;
@property(nonatomic,strong)NSMutableDictionary *registerInputTFValueMutDic;

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock jobsAppDoorContentViewBlock;

@end

@implementation JobsAppDoorContentView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor2;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        //进页面最初是登录
        self.toRegisterBtn.alpha = 1;
        self.titleLab.alpha = 1;
        [self makeInputView];
        self.abandonLoginBtn.alpha = 1;
        self.sendBtn.alpha = 1;
        self.storeCodeBtn.alpha = 1;
        self.findCodeBtn.alpha = 1;
        self.isOK = YES;
    }
}
// sendBtn的状态
-(void)sendBtnCheckWithDic:(NSMutableDictionary *)inputTFValueMutDic
    userInteractionEnabled:(SEL)checkSendBtnCanBeUsed
                      data:(id _Nullable)data{
    if ([data isKindOfClass:NSDictionary.class]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        JobsAppDoorInputViewTFModel *inputViewTFModel = dataDic[@"TFResModel"];
        
        NSLog(@"KKJ%@",inputViewTFModel.resString);
        
        [inputTFValueMutDic setValue:inputViewTFModel.resString
                              forKey:dataDic[@"PlaceHolder"]];
    }
    
    SuppressWarcPerformSelectorLeaksWarning(self.sendBtn.userInteractionEnabled = [self performSelector:checkSendBtnCanBeUsed]);
    if (self.sendBtn.userInteractionEnabled) {
        self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
    }else{
        self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.3];
    }
}
//监测输入字符回调 和 激活的textField 和 toRegisterBtn/abandonLoginBtn点击事件
-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock{
    self.jobsAppDoorContentViewBlock = jobsAppDoorContentViewBlock;
}
//Core
-(void)makeInputView{
    for (int i = 0; i < self.loginDoorInputViewBaseStyleModelMutArr.count; i++) {
        JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
        [self.inputViewMutArr addObject:inputView];
        [self.loginDoorInputViewBaseStyleMutArr addObject:inputView];
        [inputView richElementsInViewWithModel:self.loginDoorInputViewBaseStyleModelMutArr[i]];
        @weakify(self)
        //【用户名 & 密码 输入回调，共享注册与登录两个界面】
        [inputView actionBlockDoorInputViewStyle_3:^(id data) {
            @strongify(self)
            if ([self.sendBtn.titleLabel.text isEqualToString:@"登录"]) {
                [self sendBtnCheckWithDic:self.loginInputTFValueMutDic
                   userInteractionEnabled:@selector(checkLoginBtnCanBeUsed)
                                     data:data];
            }else if([self.sendBtn.titleLabel.text isEqualToString:@"注册"]){
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:data];
            }else{}
            // 回调到外层，如果外层需要用的话
            if (self.jobsAppDoorContentViewBlock) {
                self.jobsAppDoorContentViewBlock(data);//data：监测输入字符回调 和 激活的textField
            }
        }];
        [self addSubview:inputView];
        inputView.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
        inputView.x = 20;
        if (i == 0) {
            inputView.top = self.titleLab.bottom + 20;//20是偏移量
        }else if(i == 1){
            JobsAppDoorInputViewBaseStyle_3 *lastObj = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[i - 1];
            inputView.top = lastObj.bottom + InputViewOffset;
        }else{}
        inputView.layer.cornerRadius = ThingsHeight / 2;
        [self layoutIfNeeded];// 这句话不加，不刷新界面，placeHolder会出现异常
    }
}
/// 返回NO 登录按钮不可点击
-(BOOL)checkLoginBtnCanBeUsed{
    NSLog(@"self.inputTFValueMutDic = %@",self.loginInputTFValueMutDic);
    if (self.loginInputTFValueMutDic.count == self.loginDoorInputViewBaseStyleModelMutArr.count) {
        BOOL r = YES;
        for (JobsAppDoorInputViewBaseStyleModel *inputViewBaseStyleModel in self.loginDoorInputViewBaseStyleModelMutArr) {
            r &= ![NSString isNullString:(NSString *)self.loginInputTFValueMutDic[inputViewBaseStyleModel.placeHolderStr]];
        }return r;
    }else{
        return NO;
    }
}
/// 返回NO 注册按钮不可点击
-(BOOL)checkRegisterBtnCanBeUsed{
    if (self.registerInputTFValueMutDic.count == self.registerDoorInputViewBaseStyleModelMutArr.count) {
        BOOL r = YES;
        for (JobsAppDoorInputViewBaseStyleModel *inputViewBaseStyleModel in self.registerDoorInputViewBaseStyleModelMutArr) {
            r &= ![NSString isNullString:(NSString *)self.registerInputTFValueMutDic[inputViewBaseStyleModel.placeHolderStr]];
        }return r;
    }else{
        return NO;
    }
}

-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{}

-(void)animationChangeRegisterBtnFrame{
    /*
     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
     *    dampingRatio 阻尼
     *    velocity 速度
     */
    @weakify(self)
    [UIView animateWithDuration:0.7
                          delay:0.1
         usingSpringWithDamping:1
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        @strongify(self)
        if (self.toRegisterBtn.selected) {//点击了“新用户注册”按钮，正在进入注册页面
            
            self.abandonLoginBtn.alpha = 0;
            self.storeCodeBtn.alpha = 0;
            self.findCodeBtn.alpha = 0;

            [self.sendBtn setTitle:@"注册"
                          forState:UIControlStateNormal];
            self.sendBtn.x = self.toRegisterBtn.width + 20;
            self.sendBtn.bottom = JobsAppDoorContentViewLeftHeight - 20;
            self.sendBtn.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
            
            self.titleLab.centerX = (self.width + self.toRegisterBtn.width) / 2;
            self.titleLab.text = @"注册";
            [self.toRegisterBtn setTitle:btnTitle1
                                forState:UIControlStateNormal];
            [self.toRegisterBtn setImage:KIMG(@"用户名称")
                                forState:UIControlStateNormal];
            for (int i = 0;
                 i < self.loginDoorInputViewBaseStyleMutArr.count;
                 i++) {
                JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[i];
                inputView.x += RegisterBtnWidth;
            }
            
            if (self.registerDoorInputViewBaseStyleMutArr.count) {//不是第一次
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:nil];
                for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
                     i < self.registerDoorInputViewBaseStyleModelMutArr.count;
                     i++) {
                    JobsAppDoorInputViewBaseStyle *inputView = (JobsAppDoorInputViewBaseStyle *)self.registerDoorInputViewBaseStyleMutArr[i];
                    inputView.alpha = 1;
                }
            }else{//第一次
                
                self.sendBtn.userInteractionEnabled = NO;
                if (self.sendBtn.userInteractionEnabled) {
                    self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
                }else{
                    self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.3];
                }
                
                [self.registerDoorInputViewBaseStyleMutArr addObjectsFromArray:self.loginDoorInputViewBaseStyleMutArr];
                for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
                     i < self.registerDoorInputViewBaseStyleModelMutArr.count;
                     i++) {

                    JobsAppDoorInputViewBaseStyle *doorInputViewBaseStyle = nil;
                    if (i == self.loginDoorInputViewBaseStyleMutArr.count) {// 确认密码
                        JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
                        doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
                        [self addSubview:inputView];
                        [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
                        [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
                        @weakify(self)
                        //监测输入字符回调 和 激活的textField【确认密码输入回调】
                        [inputView actionBlockDoorInputViewStyle_3:^(id data) {
                            @strongify(self)
                            [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                               userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                                 data:data];
                        }];
                    }else if (i == self.loginDoorInputViewBaseStyleMutArr.count + 1){// 手机验证码
                        JobsAppDoorInputViewBaseStyle_1 *inputView = JobsAppDoorInputViewBaseStyle_1.new;
                        doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
                        [self addSubview:inputView];
                        [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
                        [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
                        @weakify(self)
                        //监测输入字符回调 和 激活的textField 【手机验证码输入回调】
                        [inputView actionBlockDoorInputViewStyle_1:^(id data) {
                            @strongify(self)
                            [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                               userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                                 data:data];
                        }];
                    }else if (i == self.loginDoorInputViewBaseStyleMutArr.count + 2){// 图形验证码
                        JobsAppDoorInputViewBaseStyle_4 *inputView = JobsAppDoorInputViewBaseStyle_4.new;
                        doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
                        [self addSubview:inputView];
                        [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
                        [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
                        @weakify(self)
                        //监测输入字符回调 和 激活的textField 【图形验证码 输入回调】
                        [inputView actionBlockDoorInputViewStyle_4:^(id data) {
                            @strongify(self)
                            [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                               userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                                 data:data];
                        }];
                    }else{}
                    
                    JobsAppDoorInputViewBaseStyle *lastObj = (JobsAppDoorInputViewBaseStyle *)self.registerDoorInputViewBaseStyleMutArr[i - 1];
                    doorInputViewBaseStyle.top = lastObj.bottom + InputViewOffset;
                    doorInputViewBaseStyle.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
                    doorInputViewBaseStyle.x = 20 + RegisterBtnWidth;
                    doorInputViewBaseStyle.layer.cornerRadius = ThingsHeight / 2;
                }
            }
        }else{//点击了“返回登录”按钮，正在进入登录页面
            
            self.abandonLoginBtn.alpha = 1;
            self.storeCodeBtn.alpha = 1;
            self.findCodeBtn.alpha = 1;
            
            if (![NSString isNullString:self.registerInputTFValueMutDic[@"用户名"]] &&
                [NSString isNullString:self.loginInputTFValueMutDic[@"用户名"]]) {
                [self.loginInputTFValueMutDic setValue:self.registerInputTFValueMutDic[@"用户名"] forKey:@"用户名"];
            }else{
                [self.loginInputTFValueMutDic setValue:@"" forKey:@"用户名"];
            }
            
            if (![NSString isNullString:self.registerInputTFValueMutDic[@"密码"]] &&
                [NSString isNullString:self.loginInputTFValueMutDic[@"密码"]]) {
                [self.loginInputTFValueMutDic setValue:self.registerInputTFValueMutDic[@"密码"] forKey:@"密码"];
            }else{
                [self.loginInputTFValueMutDic setValue:@"" forKey:@"密码"];
            }
            
            [self sendBtnCheckWithDic:self.loginInputTFValueMutDic
               userInteractionEnabled:@selector(checkLoginBtnCanBeUsed)
                                 data:nil];
            
            [self.sendBtn setTitle:@"登录"
                          forState:UIControlStateNormal];
            self.sendBtn.x = 20;
            self.sendBtn.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
            self.sendBtn.bottom = self.abandonLoginBtn.top - 10;
            
            self.titleLab.centerX = (self.width - self.toRegisterBtn.width) / 2;
            self.titleLab.text = @"登录";
            [self.toRegisterBtn setTitle:btnTitle2
                                forState:UIControlStateNormal];
            [self.toRegisterBtn setImage:KIMG(@"用户名称")
                                forState:UIControlStateNormal];
            for (int i = 0; i < self.loginDoorInputViewBaseStyleMutArr.count; i++) {
                JobsAppDoorInputViewBaseStyle_4 *inputView = (JobsAppDoorInputViewBaseStyle_4 *)self.loginDoorInputViewBaseStyleMutArr[i];
                inputView.x = 20;
            }
            
            for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
                 i < self.registerDoorInputViewBaseStyleModelMutArr.count;
                 i++) {
                JobsAppDoorInputViewBaseStyle_4 *inputView = (JobsAppDoorInputViewBaseStyle_4 *)self.registerDoorInputViewBaseStyleMutArr[i];
                inputView.alpha = 0;
            }
        }
        
        if (self.jobsAppDoorContentViewBlock) {
            self.jobsAppDoorContentViewBlock(self.toRegisterBtn);
        }
        
        [self.toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = Cor1;
        [_toRegisterBtn setTitleColor:Cor2
                             forState:UIControlStateNormal];
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:13
                                                           weight:UIFontWeightMedium];
        [_toRegisterBtn setTitle:btnTitle2
                        forState:UIControlStateNormal];
        [_toRegisterBtn setImage:KIMG(@"用户名称")
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self endEditing:YES];
            [self animationChangeRegisterBtnFrame];
        }];
        [self addSubview:_toRegisterBtn];
        _toRegisterBtn.frame = CGRectMake(self.width - RegisterBtnWidth,
                                          0,
                                          RegisterBtnWidth,
                                          self.height);
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:20
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.width - self.toRegisterBtn.width) / 2;
        _titleLab.top = 20;
    }return _titleLab;
}

-(UIButton *)abandonLoginBtn{
    if (!_abandonLoginBtn) {
        _abandonLoginBtn = UIButton.new;
        [_abandonLoginBtn setTitle:@"随便逛逛"
                          forState:UIControlStateNormal];
        [_abandonLoginBtn setTitleColor:kWhiteColor
                               forState:UIControlStateNormal];
        _abandonLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                             weight:UIFontWeightSemibold];
        [_abandonLoginBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_abandonLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.jobsAppDoorContentViewBlock) {
                self.jobsAppDoorContentViewBlock(x);
            }
        }];
        [self addSubview:_abandonLoginBtn];
        _abandonLoginBtn.x = self.titleLab.x;
        _abandonLoginBtn.bottom = self.height - 30;
        _abandonLoginBtn.size = CGSizeMake(SCREEN_WIDTH / 5, 10);
    }return _abandonLoginBtn;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        [_sendBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.3];
        [_sendBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                     weight:UIFontWeightSemibold];
        [_sendBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if ([x.titleLabel.text isEqualToString:@"登录"]) {
              
            }else if ([x.titleLabel.text isEqualToString:@"注册"]){
        
            }else{}
        }];
        [self addSubview:_sendBtn];
        _sendBtn.x = 20;
        _sendBtn.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
        _sendBtn.bottom = self.abandonLoginBtn.top - 10;
        [UIView cornerCutToCircleWithView:_sendBtn andCornerRadius:_sendBtn.height / 2];
    }return _sendBtn;
}
/// 记住登录成功的账号和密码
-(UIButton *)storeCodeBtn{
    if (!_storeCodeBtn) {
        _storeCodeBtn = UIButton.new;
        [_storeCodeBtn setTitle:@"记住密码"
                       forState:UIControlStateNormal];
        _storeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightRegular];
        _storeCodeBtn.selected = YES;// 默认记住密码
        [_storeCodeBtn setImage:KIMG(@"没有记住密码")
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:KIMG(@"记住密码")
                       forState:UIControlStateSelected];
        _storeCodeBtn.titleLabel.textColor = kWhiteColor;
        [_storeCodeBtn.titleLabel sizeToFit];
        [_storeCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        [self addSubview:_storeCodeBtn];
        [_storeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.inputViewMutArr.lastObject;
            make.left.equalTo(inputView).offset(20);
            make.top.equalTo(inputView.mas_bottom).offset(20);
        }];
        @weakify(self)
        [[_storeCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            if (self.jobsAppDoorContentViewBlock) {
                self.jobsAppDoorContentViewBlock(x);
            }
        }];
    }return _storeCodeBtn;
}

-(UIButton *)findCodeBtn{
    if (!_findCodeBtn) {
        _findCodeBtn = UIButton.new;
        [_findCodeBtn setTitle:@"忘记密码"
                      forState:UIControlStateNormal];
        _findCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                         weight:UIFontWeightRegular];
        _findCodeBtn.titleLabel.textColor = kWhiteColor;
        [_findCodeBtn.titleLabel sizeToFit];
        [_findCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        [self addSubview:_findCodeBtn];
        [_findCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.inputViewMutArr.lastObject;
            make.right.equalTo(inputView).offset(-20);
            make.top.equalTo(inputView.mas_bottom).offset(15);
        }];
        @weakify(self)
        [[_findCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.jobsAppDoorContentViewBlock) {
                self.jobsAppDoorContentViewBlock(x);
            }
        }];
    }return _findCodeBtn;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)loginDoorInputViewBaseStyleModelMutArr{
    if (!_loginDoorInputViewBaseStyleModelMutArr) {
        _loginDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;
        
        JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
        用户名.leftViewIMG = KIMG(@"用户名称");
        用户名.placeHolderStr = @"用户名";
        用户名.isShowDelBtn = YES;
        用户名.isShowSecurityBtn = NO;
        用户名.returnKeyType = UIReturnKeyDone;
        用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
        用户名.leftViewMode = UITextFieldViewModeAlways;
        [_loginDoorInputViewBaseStyleModelMutArr addObject:用户名];
        
        JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
        密码.leftViewIMG = KIMG(@"Lock");
        密码.placeHolderStr = @"密码";
        密码.isShowDelBtn = YES;
        密码.isShowSecurityBtn = YES;
        密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        密码.unSelectedSecurityBtnIMG =KIMG(@"codeDecode");//开眼
        密码.returnKeyType = UIReturnKeyDone;
        密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        密码.leftViewMode = UITextFieldViewModeAlways;
        [_loginDoorInputViewBaseStyleModelMutArr addObject:密码];
        
    }return _loginDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)registerDoorInputViewBaseStyleModelMutArr{
    if (!_registerDoorInputViewBaseStyleModelMutArr) {
        _registerDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;
        
        JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
        用户名.leftViewIMG = KIMG(@"用户名称");
        用户名.placeHolderStr = @"用户名";
        用户名.isShowDelBtn = YES;
        用户名.isShowSecurityBtn = NO;
        用户名.returnKeyType = UIReturnKeyDone;
        用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
        用户名.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:用户名];
        
        JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
        密码.leftViewIMG = KIMG(@"Lock");
        密码.placeHolderStr = @"密码";
        密码.isShowDelBtn = YES;
        密码.isShowSecurityBtn = YES;
        密码.returnKeyType = UIReturnKeyDone;
        密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        密码.unSelectedSecurityBtnIMG = KIMG(@"codeDecode");//开眼
        密码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:密码];
        
        JobsAppDoorInputViewBaseStyleModel *确认密码 = JobsAppDoorInputViewBaseStyleModel.new;
        确认密码.leftViewIMG = KIMG(@"Lock");
        确认密码.placeHolderStr = @"确认密码";
        确认密码.isShowDelBtn = YES;
        确认密码.isShowSecurityBtn = YES;
        确认密码.returnKeyType = UIReturnKeyDone;
        确认密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        确认密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        确认密码.unSelectedSecurityBtnIMG =KIMG(@"codeDecode");//开眼
        确认密码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:确认密码];
        
        JobsAppDoorInputViewBaseStyleModel *推广码 = JobsAppDoorInputViewBaseStyleModel.new;
        推广码.leftViewIMG = KIMG(@"推广码");
        推广码.placeHolderStr = @"手机验证码";
        推广码.isShowDelBtn = YES;
        推广码.isShowSecurityBtn = NO;
        推广码.returnKeyType = UIReturnKeyDone;
        推广码.keyboardAppearance = UIKeyboardAppearanceAlert;
        推广码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:推广码];
        
        JobsAppDoorInputViewBaseStyleModel *图形验证码 = JobsAppDoorInputViewBaseStyleModel.new;
        图形验证码.leftViewIMG = KIMG(@"验证ICON");
        图形验证码.placeHolderStr = @"图形验证码";
        图形验证码.isShowDelBtn = YES;
        图形验证码.isShowSecurityBtn = NO;
        图形验证码.returnKeyType = UIReturnKeyDone;
        图形验证码.keyboardAppearance = UIKeyboardAppearanceAlert;
        图形验证码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:图形验证码];
        
    }return _registerDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)loginDoorInputViewBaseStyleMutArr{
    if (!_loginDoorInputViewBaseStyleMutArr) {
        _loginDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _loginDoorInputViewBaseStyleMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)registerDoorInputViewBaseStyleMutArr{
    if (!_registerDoorInputViewBaseStyleMutArr) {
        _registerDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _registerDoorInputViewBaseStyleMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle_3 *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableDictionary *)loginInputTFValueMutDic{
    if (!_loginInputTFValueMutDic) {
        _loginInputTFValueMutDic = NSMutableDictionary.dictionary;
    }return _loginInputTFValueMutDic;
}

-(NSMutableDictionary *)registerInputTFValueMutDic{
    if (!_registerInputTFValueMutDic) {
        _registerInputTFValueMutDic = [NSMutableDictionary dictionaryWithDictionary:self.loginInputTFValueMutDic];
    }return _registerInputTFValueMutDic;
}

@end
