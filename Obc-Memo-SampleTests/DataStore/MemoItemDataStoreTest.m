//
//  MemoItemDataStoreTest.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/08.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager.h"
#import "MemoItemDataStore.h"

@interface MemoItemDataStoreTest : XCTestCase

@end

@implementation MemoItemDataStoreTest

- (void)setUp {
    [self deleteAllMemoItem];
}

- (void)tearDown {
    [self deleteAllMemoItem];
}

- (void)test_create_任意のEntityを新規作成できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"任意のEntityを新規作成できること"];
    MemoItemDataStoreImpl * dataStore = [MemoItemDataStoreImpl new];
    [dataStore create:@"MemoItem" completion:^(MemoItem * _Nullable memoItem,
                                               CoreDataError * _Nullable error) {
        if (error != nil || memoItem == nil) {
            XCTFail();
        }
        XCTAssertNotNil(memoItem.uniqueId);
        [memoItem.managedObjectContext deleteObject:memoItem];
        [expectation fulfill];
    }];
    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:1.0];
}

- (void)test_fetchArray_条件を指定してEntityの配列を取得できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"条件を指定してEntityの配列を取得できること"];
    MemoItemDataStoreImpl * dataStore = [MemoItemDataStoreImpl new];
    NSString * entityName = @"MemoItem";
    dispatch_group_t group = dispatch_group_create();

    for(int i=0; i<3; i++){
        dispatch_group_enter(group);
        [dataStore create:entityName completion:^(MemoItem * _Nullable memoItem, CoreDataError * _Nullable error) {
            memoItem.uniqueId = [NSString stringWithFormat:@"テスト%d", i];
            [dataStore save:memoItem];
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    NSPredicate * _Nonnull predicate1 = [NSPredicate predicateWithFormat:@"uniqueId == %@", @"テスト1"];
    NSPredicate * _Nonnull predicate2 = [NSPredicate predicateWithFormat:@"uniqueId == %@", @"テスト2"];
    NSArray<NSPredicate *> * _Nonnull predicateArray = [[NSArray alloc] initWithObjects:predicate1, predicate2, nil];
    NSCompoundPredicate * _Nonnull predicates = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
    bool ascending = NO;
    [dataStore fetchArray:predicates
                  sortKey:@"editDate"
                ascending:&ascending
               completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
        if (error != nil || memoItems == nil) {
            XCTFail();
        }
        XCTAssertEqual(memoItems.count, 2);
        [expectation fulfill];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:1.0];
}

- (void)test_execute_リクエストが実行されていること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"リクエストが実行されていること"];
    MemoItemDataStoreImpl * dataStore = [MemoItemDataStoreImpl new];
    NSString * entityName = @"MemoItem";
    int allMemoItemsCount = 100;
    dispatch_group_t group = dispatch_group_create();

    for(int i=0; i<allMemoItemsCount; i++){
        dispatch_group_enter(group);
        [dataStore create:entityName completion:^(MemoItem * _Nullable memoItem, CoreDataError * _Nullable error) {
            memoItem.uniqueId = [NSString stringWithFormat:@"テスト%d", i];
            [dataStore save:memoItem];
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSArray<NSPredicate *> * _Nonnull predicateArray = [NSArray new];
    NSCompoundPredicate * _Nonnull predicates = [NSCompoundPredicate andPredicateWithSubpredicates:predicateArray];
    NSString * sortKey = @"editDate";
    bool ascending = NO;
    [dataStore fetchArray:predicates
                  sortKey:sortKey
                ascending:&ascending
               completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
        XCTAssertEqual(memoItems.count, allMemoItemsCount,
                       @"削除実行前はallMemosCount分の要素があるはず");

        NSFetchRequest<MemoItem *> * request = [[NSFetchRequest alloc] initWithEntityName:@"MemoItem"];
        NSBatchDeleteRequest * deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];

        CoreDataError * _Nullable coreDataError = [dataStore execute:deleteRequest];

        XCTAssertTrue(coreDataError == nil);

        [dataStore fetchArray:predicates
                      sortKey:sortKey
                    ascending:&ascending
                   completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
            if (error != nil || memoItems == nil) {
                XCTFail();
            }
            XCTAssertEqual(memoItems.count, 0);
            [expectation fulfill];
        }];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3.0];
}

- (void)test_delete_指定した1件のEntityを削除できること {
    XCTestExpectation *expectation = [self expectationWithDescription:@"指定した1件のEntityを削除できること"];
    MemoItemDataStoreImpl * dataStore = [MemoItemDataStoreImpl new];
    NSString * entityName = @"MemoItem";
    int allMemoItemsCount = 3;
    NSMutableArray<MemoItem *> * dummyArray = [[NSMutableArray alloc] init];
    dispatch_group_t group = dispatch_group_create();

    for(int i=0; i<allMemoItemsCount; i++){
        dispatch_group_enter(group);
        [dataStore create:entityName completion:^(MemoItem * _Nullable memoItem, CoreDataError * _Nullable error) {
            memoItem.uniqueId = [NSString stringWithFormat:@"%d", i];
            [dataStore save:memoItem];
            [dummyArray addObject:memoItem];
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSArray<NSPredicate *> * _Nonnull predicateArray = [NSArray new];
    NSCompoundPredicate * _Nonnull predicates = [NSCompoundPredicate andPredicateWithSubpredicates:predicateArray];
    NSString * sortKey = @"editDate";
    bool ascending = NO;
    [dataStore fetchArray:predicates
                  sortKey:sortKey
                ascending:&ascending
               completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
        XCTAssertEqual(memoItems.count, allMemoItemsCount, @"削除実行前はallMemosCount分の要素があるはず");

        [dummyArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"uniqueId == %@", @"2"]];
        MemoItem * deleteItem = dummyArray[0];

        [dataStore delete:deleteItem completion:^{
            [dataStore fetchArray:predicates
                          sortKey:sortKey
                        ascending:&ascending
                       completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
                if (error != nil || memoItems == nil) {
                    XCTFail();
                }
                XCTAssertEqual(memoItems.count, 2);
                NSMutableArray<MemoItem *> * dummyMemosArray = [[NSMutableArray alloc] initWithArray:memoItems];
                [dummyMemosArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"uniqueId == %@", @"2"]];
                XCTAssertEqual(dummyMemosArray.count, 0);
                [expectation fulfill];
            }];
        }];
    }];

    [self waitForExpectations:[[NSArray alloc] initWithObjects:expectation, nil] timeout:3.0];
}


- (void)deleteAllMemoItem {
    NSManagedObjectContext *context = CoreDataManager.shared.persistentContainer.viewContext;
    NSFetchRequest<MemoItem *> * request = [[NSFetchRequest alloc] initWithEntityName:@"MemoItem"];
    NSBatchDeleteRequest * deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    [context executeRequest:deleteRequest error:nil];
}

@end
