//
//  NSString+.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/16.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "NSString+.h"

@implementation NSString (Lines)

- (NSString * _Nonnull)firstLine {
    NSArray<NSString *> * lines = [self componentsSeparatedByString:@"\n"];
    if (lines.count == 0) {
        return @"";
    } else {
        return lines[0];
    }
}

- (NSString * _Nonnull)afterSecondLine {
    NSMutableArray<NSString *> * mutableLines = [[NSMutableArray alloc]
                                                 initWithArray:[self componentsSeparatedByString:@"\n"]];

    if (mutableLines.count <= 1) {
        return @"";
    } else {
        // 1行目を削除
        [mutableLines removeObjectAtIndex:0];

        return [mutableLines componentsJoinedByString:@"\n"];
    }
}

@end
