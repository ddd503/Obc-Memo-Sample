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
    XCTestExpectation *expectation = [self expectationWithDescription:@"保存されているメモの総数を取得できること"];
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

- (void)test_createMemoItem_1件のメモを新規作成できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"1件のメモを新規作成できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSInteger allMemoItemsCount = 3;

    for(int i=0; i<allMemoItemsCount; i++){
        MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:[NSString stringWithFormat:@"%ld", (long)i]
                                                       titleText:[NSString stringWithFormat:@"title%ld", (long)i]
                                                     contentText:[NSString stringWithFormat:@"content%ld", (long)i]
                                                    editMemoDate:nil];
        [dataStore.dummyDataBase addObject:memoItem];
    }

    [repository createMemoItem:@"title1\ncontent1" uniqueId:nil completion:^(MemoItem * _Nullable memoItem,
                                                                             NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertTrue([memoItem.uniqueId isEqualToString:@"4"]);
        XCTAssertTrue([memoItem.title isEqualToString:@"title1"]);
        XCTAssertTrue([memoItem.content isEqualToString:@"content1"]);
        [expectation fulfill];
    }];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_deleteAllMemoItems_保存されているメモを全て削除できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"保存されているメモを全て削除できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSInteger allMemoItemsCount = 50;

    for(int i=0; i<allMemoItemsCount; i++){
        MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:[NSString stringWithFormat:@"%ld", (long)i]
                                                       titleText:[NSString stringWithFormat:@"title%ld", (long)i]
                                                     contentText:[NSString stringWithFormat:@"content%ld", (long)i]
                                                    editMemoDate:nil];
        [dataStore.dummyDataBase addObject:memoItem];
    }

    XCTAssertEqual((long)dataStore.dummyDataBase.count, allMemoItemsCount);

    [repository deleteAllMemoItems:@"MemoItem" completion:^(void * _Nullable (_)(void), NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertEqual((long)dataStore.dummyDataBase.count, 0);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_deleteMemoItem_ID指定で1件のメモを削除できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"1件のメモを新規作成できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSString * dummyId1 = @"10";
    NSString * dummyId2 = @"20";
    NSString * dummyId3 = @"30";

    MemoItemMock * memoItem1 = [[MemoItemMock alloc] initWith:dummyId1
                                                    titleText:dummyId1
                                                  contentText:dummyId1
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem1];

    MemoItemMock * memoItem2 = [[MemoItemMock alloc] initWith:dummyId2
                                                    titleText:dummyId2
                                                  contentText:dummyId2
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem2];

    MemoItemMock * memoItem3 = [[MemoItemMock alloc] initWith:dummyId3
                                                    titleText:dummyId3
                                                  contentText:dummyId3
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem3];

    [repository deleteMemoItem:dummyId2 completion:^(void * _Nullable (_)(void), NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertEqual((long)dataStore.dummyDataBase.count, 2);
        for (MemoItem * memoItem in dataStore.dummyDataBase) {
            XCTAssertFalse([memoItem.uniqueId isEqualToString:dummyId2]);
        }
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_readAllMemoItems_保存中のメモを全件取得できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"保存中のメモを全件取得できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSInteger allMemoItemsCount = 200;

    for(int i=0; i<allMemoItemsCount; i++){
        MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:[NSString stringWithFormat:@"%ld", (long)i]
                                                       titleText:[NSString stringWithFormat:@"title%ld", (long)i]
                                                     contentText:[NSString stringWithFormat:@"content%ld", (long)i]
                                                    editMemoDate:nil];
        [dataStore.dummyDataBase addObject:memoItem];
    }

    [repository readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertEqual((long)memoItems.count, allMemoItemsCount);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_readMemoItem_ID指定で特定のメモを1件取得できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"ID指定で特定のメモを1件取得できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSString * dummyId1 = @"10";
    NSString * dummyId2 = @"20";
    NSString * dummyId3 = @"30";

    MemoItemMock * memoItem1 = [[MemoItemMock alloc] initWith:dummyId1
                                                    titleText:dummyId1
                                                  contentText:dummyId1
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem1];

    MemoItemMock * memoItem2 = [[MemoItemMock alloc] initWith:dummyId2
                                                    titleText:dummyId2
                                                  contentText:dummyId2
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem2];

    MemoItemMock * memoItem3 = [[MemoItemMock alloc] initWith:dummyId3
                                                    titleText:dummyId3
                                                  contentText:dummyId3
                                                 editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem3];

    [repository readMemoItem:dummyId3 completion:^(MemoItem * _Nullable memoItem, NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertTrue([memoItem.uniqueId isEqualToString:dummyId3]);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

- (void)test_updateMemoItem_メモ内容を更新できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"メモ内容を更新できること"];
    MemoItemDataStoreMock * dataStore = [[MemoItemDataStoreMock alloc] initWith:YES];
    MemoItemRepositoryImpl * repository = [[MemoItemRepositoryImpl alloc] initWith:dataStore];
    NSString * dummyId = @"10";
    NSString * titleText = @"title1";
    NSString * contentText = @"content1";
    NSString * updateText = @"title2\ncontent2";

    MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:dummyId
                                                   titleText:titleText
                                                 contentText:contentText
                                                editMemoDate:nil];
    [dataStore.dummyDataBase addObject:memoItem];

    [repository updateMemoItem:dummyId text:updateText completion:^(void * _Nullable (_)(void), NSInteger * _Nullable errorCode) {
        XCTAssertEqual(errorCode, nil);
        XCTAssertEqual((long)dataStore.dummyDataBase.count, 1);
        XCTAssertTrue([dataStore.dummyDataBase[0].uniqueId isEqualToString:dummyId]);
        XCTAssertTrue([dataStore.dummyDataBase[0].title isEqualToString:@"title2"]);
        XCTAssertTrue([dataStore.dummyDataBase[0].content isEqualToString:@"content2"]);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:5.0];
}

@end
