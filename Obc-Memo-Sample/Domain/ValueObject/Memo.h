//
//  Memo.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memo : NSObject
@property (nonatomic, nonnull) NSString * uniqueId;
@property (nonatomic, nonnull) NSString * title;
@property (nonatomic, nonnull) NSString * content;
@property (nonatomic, nullable) NSDate * editDate;
- (instancetype _Nonnull )initWith:(NSString * _Nullable)uniqueId
                             title:(NSString * _Nullable)title
                           content:(NSString * _Nullable)content
                          editDate:(NSDate * _Nullable)editDate;
@end
