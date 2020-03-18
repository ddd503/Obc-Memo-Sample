//
//  MemoItemDataStoreMock.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/17.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager.h"
#import "MemoItemDataStore.h"

@interface MemoItemDataStoreMock : NSObject <MemoItemDataStore>
@property (nonatomic) NSMutableArray<MemoItem *> * dummyDataBase;
@property (nonatomic) Boolean isSuccessFunc;
- (instancetype)initWith:(Boolean)isSuccessFunc;
@end
