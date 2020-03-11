//
//  MemoItemRepository.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/09.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItemRepository.h"
#import "MemoItemDataStore.h"

@interface MemoItemRepositoryImpl ()
@property (nonatomic) NSObject<MemoItemDataStore> * _Nonnull memoItemDataStore;
@end

@implementation MemoItemRepositoryImpl

- (instancetype)initWith:(NSObject<MemoItemDataStore> * _Nonnull)memoItemDataStore {
    self = [super init];
    if (self) {
        self.memoItemDataStore = memoItemDataStore;
    }
    return self;
}


- (void)countAllMemoItems:(void (^ _Nonnull)(NSInteger * _Nonnull))completion {
    [self readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
        if (errorCode == nil) {
            completion(memoItems.count);
        } else {
            completion(0);
        }
    }];
}

- (void)createMemoItem:(NSString * _Nonnull)text uniqueId:(NSString * _Nullable)uniqueId completion:(void (^ _Nonnull)(MemoItem * _Nullable, NSInteger * _Nullable))completion {
    <#code#>
}


- (void)deleteAllMemoItems:(NSString * _Nonnull)entityName completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    <#code#>
}


- (void)deleteMemoItem:(NSString * _Nonnull)uniqueId completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    <#code#>
}


- (void)readAllMemoItems:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nullable, NSInteger * _Nullable))completion {
    <#code#>
}


- (void)readMemoItem:(NSString * _Nonnull)uniqueId completion:(void (^ _Nonnull)(MemoItem * _Nullable, NSInteger * _Nullable))completion {
    <#code#>
}


- (void)updateMemoItem:(NSString * _Nonnull)uniqueId completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    <#code#>
}

@end
