//
//  Memo.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "Memo.h"

@implementation Memo
- (instancetype)initWith:(NSString * _Nullable)uniqueId
                   title:(NSString * _Nullable)title
                 content:(NSString * _Nullable)content
                editDate:(NSDate * _Nullable)editDate {
    self = [super self];
    if (self) {
        if (uniqueId == nil) {
            self.uniqueId = @"";
        } else {
            self.uniqueId = uniqueId;
        }

        if (title == nil) {
            self.title = @"";
        } else {
            self.title = title;
        }

        if (content == nil) {
            self.content = @"";
        } else {
            self.content = content;
        }

        self.editDate = editDate;
    }
    return self;
}
@end
