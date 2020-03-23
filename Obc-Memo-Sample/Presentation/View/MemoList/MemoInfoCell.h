//
//  MemoInfoCell.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/23.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Memo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemoInfoCell : UITableViewCell
+ (NSString *)identifier;
+ (UINib *)nib;
- (void)setInfo:(Memo *)memo;
@end

NS_ASSUME_NONNULL_END
