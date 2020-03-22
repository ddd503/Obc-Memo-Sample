//
//  MemoDetailViewController.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoDetailPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemoDetailViewController : UIViewController
- (instancetype)initWith:(NSObject<MemoDetailPresenterInputs> *)presenterInputs;
@end

NS_ASSUME_NONNULL_END
