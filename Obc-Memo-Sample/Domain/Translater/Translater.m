//
//  Translater.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "Translater.h"

@implementation Translater

+ (Memo * _Nonnull)memoItemToMemo:(MemoItem * _Nonnull)memoItem {
    Memo * _Nonnull memo = [[Memo alloc] initWith:memoItem.uniqueId
                                            title:memoItem.title
                                          content:memoItem.content
                                         editDate:memoItem.editDate];
    return memo;
}

+ (NSArray<Memo *> *)memoItemsToMemos:(NSArray<MemoItem *> *)memoItems {
    NSMutableArray<Memo *> * mutableMemos = [NSMutableArray<Memo *> new];
    for (MemoItem * item in memoItems) {
        Memo * _Nonnull memo = [[Memo alloc] initWith:item.uniqueId
                                                title:item.title
                                              content:item.content
                                             editDate:item.editDate];
        [mutableMemos addObject:memo];
    }
    return [[NSArray<Memo *> alloc] initWithArray:mutableMemos];
}

@end
