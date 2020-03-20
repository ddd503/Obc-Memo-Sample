//
//  MemoItemRepositoryMock.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoItemRepository.h"

@interface MemoItemRepositoryMock : NSObject <MemoItemRepository>
@property (nonatomic) NSMutableArray<MemoItem *> * dummyDataBase;
@property (nonatomic) BOOL isSuccessFunc;
- (instancetype)initWith:(BOOL)isSuccessFunc;
@end
