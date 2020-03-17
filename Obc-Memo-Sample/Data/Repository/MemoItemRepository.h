//
//  MemoItemRepository.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/09.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItem+CoreDataClass.h"

@protocol MemoItemRepository <NSObject>

@required
- (void)createMemoItem:(NSString * _Nonnull)text
              uniqueId:(NSString * _Nullable)uniqueId
            completion:(void (^ _Nonnull)(MemoItem * _Nullable memoItem,
                                          NSInteger * _Nullable errorCode))completion;
- (void)readAllMemoItems:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nullable memoItems,
                                            NSInteger * _Nullable errorCode))completion;
- (void)readMemoItem:(NSString * _Nonnull)uniqueId
          completion:(void (^ _Nonnull)(MemoItem * _Nullable memoItem,
                                        NSInteger * _Nullable errorCode))completion;
- (void)updateMemoItem:(NSString * _Nonnull)uniqueId
                  text:(NSString * _Nonnull)text
            completion:(void (^ _Nonnull)(void * _Nullable (void),
                                          NSInteger * _Nullable errorCode))completion;
- (void)deleteAllMemoItems:(NSString * _Nonnull)entityName
                completion:(void (^ _Nonnull)(void * _Nullable (void),
                                              NSInteger * _Nullable errorCode))completion;
- (void)deleteMemoItem:(NSString * _Nonnull)uniqueId
            completion:(void (^ _Nonnull)(void * _Nullable (void),
                                          NSInteger * _Nullable errorCode))completion;
- (void)countAllMemoItems:(void (^ _Nonnull)(NSInteger * _Nonnull count))completion;
@end

@interface MemoItemRepositoryImpl : NSObject <MemoItemRepository>

@end
