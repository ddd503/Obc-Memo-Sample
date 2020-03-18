//
//  MemoItemRepositoryTest.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/18.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager.h"
#import "MemoItemRepository.h"
#import "MemoItemDataStoreMock.h"
#import "MemoItemMock.h"

@interface MemoItemRepositoryTest : XCTestCase

@end

@implementation MemoItemRepositoryTest

- (void)test_countAllMemoItems_保存されているメモの総数を取得できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"保存されているメモの総数を取得できるこ"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSInteger allMemoItemsCount = 100;

    for(int i=0; i<allMemoItemsCount; i++){
        MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:[NSString stringWithFormat:@"%ld", (long)i]
                                                       titleText:[NSString stringWithFormat:@"title%ld", (long)i]
                                                     contentText:[NSString stringWithFormat:@"content%ld", (long)i]
                                                    editMemoDate:nil];
        [dataStore.dummyDataBase addObject:memoItem];
    }

    [repository countAllMemoItems:^(NSInteger * _Nonnull count) {
        XCTAssertEqual((long)count, allMemoItemsCount);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_createMemoItem_1件のメモを新規作成できること {}

- (void)test_deleteAllMemoItems_保存されているメモを全て削除できること {}

- (void)test_deleteMemoItem_ID指定で1件のメモを削除できること {}

- (void)test_readAllMemoItems_保存中のメモを全件取得できること {}

- (void)test_readMemoItem_ID指定で特定のメモを1件取得できること {}

- (void)test_updateMemoItem_メモ内容を更新できること {}

@end
