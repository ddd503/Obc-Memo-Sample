//
//  MemoItem+CoreDataProperties.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//
//

#import "MemoItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MemoItem (CoreDataProperties)

+ (NSFetchRequest<MemoItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *uniqueId;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *editDate;

@end

NS_ASSUME_NONNULL_END
