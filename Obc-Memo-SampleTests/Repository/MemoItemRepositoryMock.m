//
//  MemoItemRepositoryMock.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItemRepositoryMock.h"
#import "MemoItemMock.h"
#import "NSString+.h"

@implementation MemoItemRepositoryMock

- (instancetype)initWith:(BOOL)isSuccessFunc {
    self = [super init];
    if (self) {
        self.dummyDataBase = [NSMutableArray<MemoItem *> new];
        self.isSuccessFunc = isSuccessFunc;
    }
    return self;
}

- (void)countAllMemoItems:(void (^ _Nonnull)(NSInteger * _Nonnull))completion {
    completion(self.dummyDataBase.count);
}

- (void)createMemoItem:(NSString * _Nonnull)text
              uniqueId:(NSString * _Nullable)uniqueId
            completion:(void (^ _Nonnull)(MemoItem * _Nullable,
                                          NSInteger * _Nullable))completion {
    if (self.isSuccessFunc) {
        MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:uniqueId
                                                       titleText:text.firstLine contentText:text.afterSecondLine editMemoDate:nil];
        [self.dummyDataBase addObject:memoItem];
        completion(memoItem, nil);
    } else {
        completion(nil, 0);
    }
}

- (void)deleteAllMemoItems:(NSString * _Nonnull)entityName
                completion:(void (^ _Nonnull)(void * _Nullable (*)(void),
                                              NSInteger * _Nullable))completion {
    if ([entityName isEqualToString:@"MemoItem"]) {
        self.dummyDataBase = [NSMutableArray<MemoItem *> new];
    }

    completion(nil, (self.isSuccessFunc) ? nil : 0);
}

- (void)deleteMemoItem:(NSString * _Nonnull)uniqueId
            completion:(void (^ _Nonnull)(void * _Nullable (*)(void),
                                          NSInteger * _Nullable))completion {
    if (self.isSuccessFunc) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"uniqueId != %@", uniqueId];
        [self.dummyDataBase filterUsingPredicate:predicate];
        completion(nil, nil);
    } else {
        completion(nil, 0);
    }
}

- (void)readAllMemoItems:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nullable,
                                            NSInteger * _Nullable))completion {
    if (self.isSuccessFunc) {
        completion(self.dummyDataBase, nil);
    } else {
        completion(nil, 0);
    }
}

- (void)readMemoItem:(NSString * _Nonnull)uniqueId
          completion:(void (^ _Nonnull)(MemoItem * _Nullable,
                                        NSInteger * _Nullable))completion {
    if (self.isSuccessFunc) {
        NSMutableArray<MemoItem *> * mutableMemos = [[NSMutableArray<MemoItem *> alloc] initWithArray:self.dummyDataBase];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", uniqueId];
        [mutableMemos filterUsingPredicate:predicate];
        if (mutableMemos.count > 0) {
            completion(mutableMemos[0], nil);
        } else {
            completion(nil, 0);
        }
    } else {
        completion(nil, 0);
    }
}

- (void)updateMemoItem:(NSString * _Nonnull)uniqueId
                  text:(NSString * _Nonnull)text
            completion:(void (^ _Nonnull)(void * _Nullable (*)(void),
                                          NSInteger * _Nullable))completion {
    if (self.isSuccessFunc) {
        NSMutableArray<MemoItem *> * mutableMemos = [[NSMutableArray<MemoItem *> alloc] initWithArray:self.dummyDataBase];
        NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"uniqueId == %@", uniqueId];
        [mutableMemos filterUsingPredicate:predicate1];
        NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"uniqueId != %@", uniqueId];
        [self.dummyDataBase filterUsingPredicate:predicate2];

        if (mutableMemos.count > 0) {
            MemoItemMock * memoItem = [[MemoItemMock alloc] initWith:mutableMemos[0].uniqueId
                                                           titleText:text.firstLine
                                                         contentText:text.afterSecondLine
                                                        editMemoDate:nil];
            [self.dummyDataBase addObject:memoItem];
            completion(nil, nil);
        } else {
            completion(nil, 0);
        }
    } else {
        completion(nil, 0);
    }
}

@end
