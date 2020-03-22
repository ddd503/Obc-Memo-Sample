//
//  MemoInfoCell.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoInfoCell.h"

@interface MemoInfoCell ()
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * contentLabel;
@property (nonatomic, weak) IBOutlet UILabel * dateLabel;
@end

@implementation MemoInfoCell

+ (NSString *)identifier {
    return [NSString stringWithFormat:@"%@", self];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self identifier] bundle:[NSBundle mainBundle]];
}

- (void)setInfo:(Memo * _Nonnull)memo {
    self.titleLabel.text = memo.title;
    self.contentLabel.text = memo.content;
    if (memo.editDate != nil) {
        NSDateFormatter * dateFormatter = [NSDateFormatter new];
        dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dateFormatter.dateFormat = @"yyyy/MM/dd  HH:mm";
        self.dateLabel.text = [dateFormatter stringFromDate:memo.editDate];
    }
}

@end
