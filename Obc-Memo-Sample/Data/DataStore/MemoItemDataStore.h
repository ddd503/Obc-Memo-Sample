//
//  MemoItemDataStore.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MemoItem+CoreDataClass.h"
#import "CoreDataError.h"

@protocol MemoItemDataStore <NSObject>
+ (void)create:(NSString * _Nonnull)entityName
    completion:(void (^ _Nonnull) (MemoItem * _Nullable memoItem,
                                   CoreDataError * _Nullable error))completion;
+ (nullable CoreDataError *)save:(NSManagedObject * _Nonnull)object;
+ (void)fetchArray:(NSArray<NSPredicate * > * _Nonnull)predicates
           sortKey:(NSString * _Nonnull)sortKey
         ascending:(BOOL * _Nonnull)ascending
       logicalType:(NSCompoundPredicateType * _Nonnull)logicalType
        completion:(void (^ _Nonnull) (NSArray<MemoItem *> * _Nonnull memoItems,
                                       CoreDataError * _Nullable error))completion;
+ (nullable CoreDataError *)execute:(NSPersistentStoreRequest * _Nonnull)request;
+ (void)delete:(NSManagedObject * _Nonnull)object completion:(void (^ _Nonnull) (void))completion;
@end

@interface MemoItemDataStoreImpl : NSObject <MemoItemDataStore>

@end
