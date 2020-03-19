//
//  Translater.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoItem+CoreDataProperties.h"
#import "Memo.h"

@interface Translater : NSObject
+ (Memo * _Nonnull)memoItemToMemo:(MemoItem * _Nonnull)memoItem;
+ (NSArray<Memo *> * _Nonnull)memoItemsToMemos:(NSArray<MemoItem *> * _Nonnull)memoItems;
@end
