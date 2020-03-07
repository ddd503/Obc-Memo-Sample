//
//  MemoItem+CoreDataProperties.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//
//

#import "MemoItem+CoreDataProperties.h"

@implementation MemoItem (CoreDataProperties)

+ (NSFetchRequest<MemoItem *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MemoItem"];
}

@dynamic uniqueId;
@dynamic title;
@dynamic content;
@dynamic editDate;

@end
