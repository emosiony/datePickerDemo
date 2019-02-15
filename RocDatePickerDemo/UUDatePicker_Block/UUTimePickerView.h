//
//  UUTimePickerView.h
//  RocDatePickerDemo
//
//  Created by Jtg_yao on 2019/1/16.
//  Copyright © 2019年 rocHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUDatePicker.h"
#import "NSDate+Extension.h"

#define HEXCOLOR(hex)       [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define kLineColor          0xF3F3F3
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kTimePickerHeight   (270.0f + kSafeAreaBottomHeight)
//底部
#define kSafeAreaBottomHeight   (isIPhoneX ? 34 : 0)
//判断是否是iPhoneX
#define isIPhoneX               (kStatusBarH != 20)
/** 状态栏 高度 iPhoneX：44 other：20 */
#define kStatusBarH             [[UIApplication sharedApplication] statusBarFrame].size.height

@class UUTimePickerView;

typedef void(^UUCancelClick)(void);
typedef void(^UUConfirmClick)(NSDate *date);

@protocol UUTimePickerDelegate <NSObject>

-(void)UUTimePickerCancelClick:(UUTimePickerView *)pickView;
-(void)UUTimePicker:(UUTimePickerView *)pickView confirmClick:(NSDate *)date;

@end

NS_ASSUME_NONNULL_BEGIN

@interface UUTimePickerView : UIView

/** 选择器时间 */
@property(nonatomic,strong)NSDate *date;

/** 标题 */
@property(nonatomic,strong)NSString *title;

/** 取消按钮 title */
@property (nonatomic,copy) NSString *cancleStr;

/** 确认按钮 title */
@property (nonatomic,copy) NSString *sureStr;

/** 最小date */
@property(nonatomic,strong)NSDate *minLimitDate;

/** 最大date */
@property(nonatomic,strong)NSDate *maxLimitDate;

/** delegate */
@property(nonatomic,weak)id <UUTimePickerDelegate> delegate;

@property(nonatomic,copy)UUCancelClick cancelBlock;
@property(nonatomic,copy)UUConfirmClick confirmBlock;

-(void)setCancelBlock:(UUCancelClick)cancelBlock
         confirmBlock:(UUConfirmClick)confirmBlock;

/**
 *  初始化
 *
 *  @param frame    frame
 *  @param pickType  类型
 *  @return   instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame pickType:(DateStyle)pickType;

/**
 *  初始化
 *
 *  @param frame    frame
 *  @param pickType  类型
 *  @return   instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
                     pickType:(DateStyle)pickType
                 confirmBlock:(UUConfirmClick)confirmBlock
                  cancelBlock:(UUCancelClick)cancelBlock;

@end

@interface UUTimeTopBarView : UIView

@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *btnCancel;
@property(nonatomic,strong)UIButton *btnConfirm;
@property(nonatomic,strong)UIView *line;

/** 标题 */
@property(nonatomic,strong)NSString *title;

/** 取消按钮 title */
@property (nonatomic,copy) NSString *cancleStr;

/** 确认按钮 title */
@property (nonatomic,copy) NSString *sureStr;

@property(nonatomic,copy)UUCancelClick cancelTopBlock;
@property(nonatomic,copy)UUCancelClick confirmTopBlock;

-(void)setConfirmTopBlock:(UUCancelClick _Nonnull)confirmTopBlock
              cancelBlock:(UUCancelClick _Nonnull)cancelTopBlock;

@end

NS_ASSUME_NONNULL_END
