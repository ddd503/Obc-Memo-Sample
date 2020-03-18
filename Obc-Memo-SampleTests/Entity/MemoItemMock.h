//
//  MemoItemMock.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/18.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoItem+CoreDataClass.h"

@interface MemoItemMock : MemoItem
- (instancetype _Nonnull)initWith:(NSString * _Nonnull)uniqueIdText
                        titleText:(NSString * _Nullable)titleText
                      contentText:(NSString * _Nullable)contentText
                     editMemoDate:(NSDate * _Nullable)editMemoDate;
@end
