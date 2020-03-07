//
//  CoreDataManager.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

// 以下シングルトンの生成

+ (CoreDataManager *)shared {
    static CoreDataManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataManager alloc] initSharedInstance];
    });
    return instance;
}

- (id)initSharedInstance {
    self = [super init];
    if (self) {
        // do something（必要がある場合）
    }
    return self;
}

- (id)init {
    // init を直接呼ぼうとしたらエラーを発生させる
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Obc_Memo_Sample"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

@end
