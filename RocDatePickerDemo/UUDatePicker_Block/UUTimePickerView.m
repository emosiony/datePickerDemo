//
//  UUTimePickerView.m
//  RocDatePickerDemo
//
//  Created by Jtg_yao on 2019/1/16.
//  Copyright © 2019年 rocHome. All rights reserved.
//

#import "UUTimePickerView.h"
#import <Masonry.h>

@interface UUTimePickerView ()
<UUDatePickerDelegate>

@property(nonatomic,strong)UUTimeTopBarView *topBar;
@property(nonatomic,strong)UUDatePicker *datePicker;

/** 选择器模式 */
@property(nonatomic,assign)DateStyle pickViewMode;

@end

@implementation UUTimePickerView

-(instancetype)initWithFrame:(CGRect)frame
                    pickType:(DateStyle)pickType
{
    if (self = [super initWithFrame:frame]) {
        _pickViewMode = pickType;
        [self subViewInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                    pickType:(DateStyle)pickType
                confirmBlock:(UUConfirmClick)confirmBlock
                 cancelBlock:(UUCancelClick)cancelBlock
{
    if (self = [super initWithFrame:frame]) {
        
        _pickViewMode = pickType;
        [self subViewInit];
        [self setCancelBlock:cancelBlock confirmBlock:confirmBlock];
    }
    return self;
}

-(void)subViewInit {
    
    _date = [NSDate date];
    self.backgroundColor = [UIColor whiteColor];

    _topBar = [[UUTimeTopBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50.5f)];
    CGFloat datePickerX = (kScreenWidth - 320.0f)/2.0f;
    
    _datePicker = [[UUDatePicker alloc] initWithframe:CGRectMake(datePickerX, 50.5f, 320, 216.0f) Delegate:self PickerStyle:_pickViewMode];
    [self addSubview:self.topBar];
    [self addSubview:self.datePicker];
    
    NSDate *nowDate = [NSDate date];
    self.datePicker.ScrollToDate = nowDate;

    __weak typeof(self) weakself = self;
    [_topBar setConfirmTopBlock:^{
        if (weakself.confirmBlock) {
            weakself.confirmBlock(weakself.date);
        } else {
            [weakself.delegate respondsToSelector:@selector(UUTimePicker:confirmClick:)] ? [weakself.delegate UUTimePicker:weakself confirmClick:weakself.date] : nil;
        }
    } cancelBlock:^{
        if (weakself.cancelBlock) {
            weakself.cancelBlock();
        } else {
            [weakself.delegate respondsToSelector:@selector(UUTimePickerCancelClick:)] ? [weakself.delegate UUTimePickerCancelClick:weakself] : nil;
        }
    }];
}

#pragma mark - UUDatePickerDelegate
-(void)uuDatePicker:(UUDatePicker *)datePicker year:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute weekDay:(NSString *)weekDay{
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,minute,@"00"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:dateStr];
    _date = date;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    _datePicker.ScrollToDate = date;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.topBar.title = title;
}

-(void)setCancleStr:(NSString *)cancleStr {
    _cancleStr = cancleStr;
    self.topBar.cancleStr = _cancleStr;
}

-(void)setSureStr:(NSString *)sureStr {
    _sureStr = sureStr;
    self.topBar.sureStr = _sureStr;
}

-(void)setMinLimitDate:(NSDate *)minLimitDate{
    _minLimitDate = minLimitDate;
    self.datePicker.minLimitDate = minLimitDate;
}

-(void)setMaxLimitDate:(NSDate *)maxLimitDate{
    _maxLimitDate = maxLimitDate;
    self.datePicker.maxLimitDate = maxLimitDate;
}

-(void)setCancelBlock:(UUCancelClick)cancelBlock
         confirmBlock:(UUConfirmClick)confirmBlock
{
    self.cancelBlock = cancelBlock;
    self.confirmBlock = confirmBlock;
}

@end


@implementation UUTimeTopBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self subViewInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self subViewInit];
    }
    return self;
}

-(void)subViewInit {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lableTitle];
    [self addSubview:self.btnConfirm];
    [self addSubview:self.btnCancel];
    [self addSubview:self.line];
    
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-10.0f);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(34.0f);
    }];
    
    [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10.0f);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(34.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnCancel.mas_right).with.offset(10.0f);
        make.right.mas_equalTo(self.btnConfirm.mas_left).with.offset(-10.0f);
        make.top.bottom.mas_equalTo(self);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)btnCancelClick{
    self.cancelTopBlock ? self.cancelTopBlock():nil;
}

-(void)btnConfirmClick{
    self.confirmTopBlock ? self.confirmTopBlock():nil;
}

-(void)setTitle:(NSString *)title {
    
    _title = title;
    _lableTitle.text = title;
}

-(void)setCancleStr:(NSString *)cancleStr {
    
    _cancleStr = cancleStr;
    [_btnCancel setTitle:_cancleStr forState:(UIControlStateNormal)];
}

-(void)setSureStr:(NSString *)sureStr {
    
    _sureStr   = sureStr;
    [_btnConfirm setTitle:_sureStr forState:(UIControlStateNormal)];
}

-(void)setConfirmTopBlock:(UUCancelClick)confirmTopBlock
              cancelBlock:(UUCancelClick)cancelTopBlock
{
    self.confirmTopBlock = confirmTopBlock;
    self.cancelTopBlock  = cancelTopBlock;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.font = [UIFont systemFontOfSize:15.0f];
        _lableTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lableTitle;
}

-(UIButton *)btnCancel{
    if(_btnCancel == nil){
        _btnCancel = [UIButton new];
        [_btnCancel setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_btnCancel.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}

-(UIButton *)btnConfirm{
    if(_btnConfirm == nil){
        _btnConfirm = [UIButton new];
        [_btnConfirm setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_btnConfirm.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _line;
}

@end
