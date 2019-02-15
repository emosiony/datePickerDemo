
//

#import "UUDatePicker_DateModel.h"
#import "NSDate+Extension.h"

@implementation UUDatePicker_DateModel

- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.year     = [NSString stringWithFormat:@"%ld",date.year];
        self.month    = [NSString stringWithFormat:@"%02ld",date.month];
        self.day      = [NSString stringWithFormat:@"%02ld",date.day];
        self.hour     = [NSString stringWithFormat:@"%02ld",date.hour];
        self.minute   = [NSString stringWithFormat:@"%02ld",date.minute];
    }
    return self;
}

@end
