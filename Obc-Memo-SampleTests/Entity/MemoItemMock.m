//
//  MemoItemMock.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/18.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItemMock.h"
#import <CoreData/CoreData.h>

@interface MemoItemMock ()
@property (nonatomic) NSString * _Nonnull uniqueIdText;
@property (nonatomic) NSString * _Nullable titleText;
@property (nonatomic) NSString * _Nullable contentText;
@property (nonatomic) NSDate * _Nullable editMemoDate;
@end

@implementation MemoItemMock

- (instancetype _Nonnull)initWith:(NSString * _Nonnull)uniqueIdText
                        titleText:(NSString * _Nullable)titleText
                      contentText:(NSString * _Nullable)contentText
                     editMemoDate:(NSDate * _Nullable)editMemoDate {
    self = [super init];
    if (self) {
        self.uniqueIdText = uniqueIdText;
        self.titleText = titleText;
        self.contentText = contentText;
        self.editMemoDate = editMemoDate;
    }
    return self;
}

- (NSString * _Nullable)uniqueId {
    return self.uniqueIdText;
}

- (void)setUniqueId:(NSString *)uniqueId {
    self.uniqueId = uniqueId;
}

- (NSString * _Nullable)title {
    return self.titleText;
}

- (void)setTitle:(NSString *)title {
    self.title = title;
}

- (NSString * _Nullable)content {
    return self.contentText;
}

- (void)setContent:(NSString *)content {
    self.content = content;
}

- (NSDate * _Nullable)editDate {
    return self.editMemoDate;
}

- (void)setEditDate:(NSDate *)editDate {
    self.editDate = editDate;
}

- (NSManagedObjectContext * _Nullable)managedObjectContext {
    return [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
}

@end
