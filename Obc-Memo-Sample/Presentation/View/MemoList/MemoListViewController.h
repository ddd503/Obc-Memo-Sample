//
//  MemoListViewController.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoListPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemoListViewController : UIViewController
- (instancetype)initWith:(NSObject<MemoListPresenterInputs> *)presenterInputs;
@end

NS_ASSUME_NONNULL_END
