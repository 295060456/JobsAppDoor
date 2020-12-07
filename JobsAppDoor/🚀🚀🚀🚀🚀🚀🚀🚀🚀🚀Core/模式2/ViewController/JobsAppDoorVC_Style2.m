//
//  JobsAppDoorVC_Style2.m
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import "JobsAppDoorVC_Style2.h"

@interface JobsAppDoorVC_Style2 ()

@property(nonatomic,strong)UIImageView *bgImgV;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,assign)CGFloat logoContentViewY;//初始高度

@property(nonatomic,strong,nullable)JobsAppDoorLoginContentView *loginContentView;//登录页面
@property(nonatomic,strong,nullable)JobsAppDoorRegisterContentView *registerContentView;//注册页面
@property(nonatomic,strong,nullable)JobsAppDoorLogoContentView *logoContentView;

@end

@implementation JobsAppDoorVC_Style2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.requestParams integerValue] == doorBgType_Image) {
        self.view = self.bgImgV;
    }else if ([self.requestParams integerValue] == doorBgType_video){
        [self.player.currentPlayerManager play];
    }else{}
    
    [self keyboard];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animationAlert:self.loginContentView];
    [UIView animationAlert:self.registerContentView];
    [UIView animationAlert:self.logoContentView];
}

-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;

//    NSMutableArray * (^currentPageDataMutArr)(CurrentPage currentPage) = ^(CurrentPage currentPage){
//        if (currentPage == CurrentPage_login) {
//            return self.jobsAppDoorContentView.loginDoorInputViewBaseStyleMutArr;
//        }else{
//            return self.jobsAppDoorContentView.registerDoorInputViewBaseStyleMutArr;
//        }
//    };
//
//    NSInteger index = 0;
//    for (JobsAppDoorInputViewBaseStyle_4 *inputView in currentPageDataMutArr(self.currentPage)) {
//        Ivar ivar = nil;
//        if (index == 0) {
//            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
//        }else if (index == 1){
//            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
//        }else if (index == 2){
//            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
//        }else if (index == 3){
//            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_1 class], "_tf");//必须是下划线接属性
//        }else if (index == 4){
//            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_4 class], "_tf");//必须是下划线接属性
//        }else{}
//
//        if (ivar) {
//            JobsMagicTextField *tf = object_getIvar(inputView, ivar);
//            self.loginDoorInputEditing |= tf.editing;
//            if (tf.editing) {
//                NSLog(@"FFF = %ld",index);//当前被激活的idx
//                self.lastTimeActivateTFIndex = self.currentActivateTFIndex;
//                self.currentActivateTFIndex = index;//赋予新值。因为同一时刻，textField有且只有一个被激活
//            }
//        }
//
//        index += 1;
//    }
//
//    if (!self.loginDoorInputEditing) {
//        NSLog(@"没有在编辑");
//        self.jobsAppDoorContentView.y = self.jobsAppDoorContentViewY;
//        self.logoContentView.y = self.logoContentViewY;
//        self.customerServiceBtn.y = self.customerServiceBtnY;
//    }else{
//        NSLog(@"在编辑");
//        NSInteger offsetIdx = self.currentActivateTFIndex - self.lastTimeActivateTFIndex;
//        self.jobsAppDoorContentView.y -= 40 * (offsetIdx + 0);
//        self.logoContentView.y -= 40 * (offsetIdx + 0);
//        self.customerServiceBtn.y -= 40 * (offsetIdx + 0);
//    }
//
//    self.loginDoorInputEditing = NO;//置空状态
}
#pragma mark —— lazyLoad
-(JobsAppDoorLoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = JobsAppDoorLoginContentView.new;
        
        _loginContentView.x = 20;
        _loginContentView.y = SCREEN_HEIGHT / 4;
        _loginContentView.height = JobsAppDoorContentViewRightHeight;
        _loginContentView.width = SCREEN_WIDTH - 40;
        
        [self.view addSubview:_loginContentView];

        [_loginContentView richElementsInViewWithModel:nil];
        @weakify(self)
        [_loginContentView actionBlockLoginContentView:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:btnTitle2] ) {
                    [self->_loginContentView removeContentViewWithOffsetY:0];
                    [self.registerContentView showContentViewWithOffsetY:0];
                }else{}
            }
        }];
        [UIView cornerCutToCircleWithView:_loginContentView
                          AndCornerRadius:8];
    }return _loginContentView;
}

-(JobsAppDoorRegisterContentView *)registerContentView{
    if (!_registerContentView) {
        _registerContentView = JobsAppDoorRegisterContentView.new;
        
        _registerContentView.x = SCREEN_WIDTH + 20;
        _registerContentView.y = SCREEN_HEIGHT / 4;
        _registerContentView.height = JobsAppDoorContentViewLeftHeight;
        _registerContentView.width = SCREEN_WIDTH - 40;
        
        [self.view addSubview:_registerContentView];
        [_registerContentView richElementsInViewWithModel:nil];
        @weakify(self)
        [_registerContentView actionBlockRegisterContentView:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:btnTitle1]){
                    [self.registerContentView removeContentViewWithOffsetY:0];
                    [self->_loginContentView showContentViewWithOffsetY:0];
                }else{}
            }
        }];
        [UIView cornerCutToCircleWithView:_registerContentView AndCornerRadius:8];
    }return _registerContentView;
}

-(JobsAppDoorLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = JobsAppDoorLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.bottom.equalTo(self.loginContentView.mas_top).offset(-50);
            make.centerX.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.logoContentViewY = self.logoContentView.y;
    }return _logoContentView;
}

@end
