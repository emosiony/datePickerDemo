//
//  ViewController.m
//  RocDatePickerDemo
//
//  Created by Jtg_yao on 2019/1/16.
//  Copyright © 2019年 rocHome. All rights reserved.
//

#import "ViewController.h"
#import "UUTimePickerView.h"
#import <zhPopupController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *contents = @[@"年月日时分",@"年月日",
                          @"月日时分",@"时分"];
    
    [contents enumerateObjectsUsingBlock:^(NSString * _Nonnull content, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat height = 35;
        CGFloat textHeight = 20;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100 + idx * (height + textHeight + 10), self.view.bounds.size.width-100, height)];
        [btn setTitle:content forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor lightTextColor];
        btn.tag = 10 + idx;
        [btn addTarget:self action:@selector(tapClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame), CGRectGetWidth(btn.frame), textHeight)];
        label.textColor = [UIColor darkTextColor];
        label.font      = [UIFont systemFontOfSize:13];
        label.tag       = btn.tag + 100;
        label.text      = content;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }];
}

-(void)tapClick:(UIButton *)sender {
    
    DateStyle dateStyle = (int)sender.tag - 10;
    __weak typeof(self) weakSelf = self;
    UUTimePickerView *pickerView = [[UUTimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTimePickerHeight) pickType:dateStyle confirmBlock:^(NSDate *date) {
        NSString *time = [NSDate stringWithDate:date format:[self dateFormatter:(int)sender.tag - 10]];
        UILabel *label = (UILabel *)[self.view viewWithTag:sender.tag + 100];
        label.text     = time;
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
}

-(NSString *)dateFormatter:(DateStyle)style {
    
    NSString *formmater = @"yyyy-MM-dd HH:mm:dd";
    switch (style) {
        case UUDateStyle_YearMonthDayHourMinute:
            formmater = @"yyyy-MM-dd HH:mm";
            break;
        case UUDateStyle_YearMonthDay:
            formmater = @"yyyy-MM-dd";
            break;
        case UUDateStyle_MonthDayHourMinute:
            formmater = @"MM-dd HH:mm";
            break;
        case UUDateStyle_HourMinute:
            formmater = @"HH:mm";
            break;
        default:
            break;
    }
    
    return formmater;
}

-(BOOL)returnDate:(NSString *)date {
    if (date != nil && date.length > 0) {
        return true;
    }
    return false;
}

@end
