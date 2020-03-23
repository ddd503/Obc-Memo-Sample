//
//  MemoInfoCell.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/23.
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
    NSLog(@"%@", [NSString stringWithFormat:@"%@", self]);
    return [NSString stringWithFormat:@"%@", self];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self identifier] bundle:nil];
}

- (void)setInfo:(Memo *)memo {
    self.titleLabel.text = memo.title;
    self.contentLabel.text = memo.content;
    if (memo.editDate != nil) {
        NSDateFormatter * formatter = [NSDateFormatter new];
        formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        formatter.dateFormat = @"yyyy/MM/dd  HH:mm";
        self.dateLabel.text = [formatter stringFromDate:memo.editDate];
    }
}

@end
