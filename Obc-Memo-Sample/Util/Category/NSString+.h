//
//  NSString+.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/16.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Lines)
@property (nonatomic, readonly) NSString * _Nonnull firstLine;
@property (nonatomic, readonly) NSString * _Nonnull afterSecondLine;
@end
