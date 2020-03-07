//
//  CoreDataError.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CoreDataError) {
    FailedCreateEntity = 1,
    FailedGetManagedObject,
    FailedFetchRequest,
    FailedExecuteStoreRequest,
    NotFoundContext,
    FailedFetchMemoById,
    FailedSaveContext
};
