# RocDatePickerDemo

#### 介绍
时间选择：4种类型
1、年月日时分
2、年月日
3、月日时分
4、时分
依赖 zhPopupController、Masonry

#### 软件架构
软件架构说明


#### 安装教程

1. xxxx
2. xxxx
3. xxxx

#### 使用说明

    DateStyle dateStyle = UUDateStyle_YearMonthDayHourMinute;
    __weak typeof(self) weakSelf = self;
    UUTimePickerView *pickerView = [[UUTimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTimePickerHeight) pickType:dateStyle confirmBlock:^(NSDate *date) {
        NSLog(@"时间 == %@", date);
        [weakSelf.zh_popupController dismiss];
    } cancelBlock:^{
        [weakSelf.zh_popupController dismiss];
    }];
    pickerView.maxLimitDate = [NSDate date];
    pickerView.title = @"时间选择";
    
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    self.zh_popupController.dismissOnMaskTouched = NO;
    [self.zh_popupController presentContentView:pickerView duration:0.25 springAnimated:YES];


#### 参与贡献

1. Fork 本仓库
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request


#### 码云特技

1. 使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2. 码云官方博客 [blog.gitee.com](https://blog.gitee.com)
3. 你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解码云上的优秀开源项目
4. [GVP](https://gitee.com/gvp) 全称是码云最有价值开源项目，是码云综合评定出的优秀开源项目
5. 码云官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6. 码云封面人物是一档用来展示码云会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)