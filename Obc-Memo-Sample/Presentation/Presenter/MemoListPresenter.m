//
//  MemoListPresenter.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MemoListPresenter.h"
#import "Translater.h"

@implementation MemoListPresenter

@synthesize memosImpl;
@synthesize tableViewEditing;
@synthesize tappedActionSheet;

- (NSMutableArray<Memo *> *)memos {
    return self.memosImpl;
}

- (void)setMemos:(NSMutableArray<Memo *> *)memos {
    self.memosImpl = memos;
    [self.view updateMemoList:memos];
}

- (void)setTableViewEditing:(BOOL)tableViewEditing {
    [self.view updateTableViewIsEditing:tableViewEditing];
    [self.view updateButtonTitle:tableViewEditing ? @"全て削除" : @"メモ追加"];
}

- (void)setTappedActionSheet:(void (^)(AlertEventType))tappedActionSheet {
    __weak typeof(self) wself = self;
    self.tappedActionSheet = ^(AlertEventType type) {
        switch (type) {
            case AllDelete: {
                [wself.memoItemRepository deleteAllMemoItems:@"MemoItem" completion:^(void * _Nullable (_)(void), NSInteger * _Nullable errorCode) {
                    if (errorCode == nil) {
                        [wself.memoItemRepository readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
                            if (errorCode == nil) {
                                wself.memos = [Translater memoItemsToMemos:memoItems];
                            } else {
                                [wself.view showErrorAlert:[NSString stringWithFormat:@"%ld", (long)errorCode]];
                            }
                        }];
                    } else {
                        [wself.view showErrorAlert:[NSString stringWithFormat:@"%ld", (long)errorCode]];
                    }
                }];
            }
                break;

            case Cancel:
                break;
        };
    };
}

- (instancetype)initWith:(NSObject<MemoItemRepository> *)memoItemRepository {
    self = [super init];
    if (self) {
        self.memoItemRepository = memoItemRepository;
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(didSaveMemo:)
                                                   name:NSManagedObjectContextDidSaveNotification
                                                 object:nil];
    }
    return self;
}

- (void)bind:(NSObject<MemoListPresenterOutputs> *)view {
    self.view = view;
}

- (void)deleteMemo:(NSString *)uniqueId {
    __weak typeof(self) wself = self;
    [self.memoItemRepository deleteMemoItem:uniqueId completion:^(void * _Nullable (_)(void), NSInteger * _Nullable errorCode) {
        if (errorCode == nil) {
            [wself.memoItemRepository readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
                if (errorCode == nil) {
                    wself.memos = [Translater memoItemsToMemos:memoItems];
                } else {
                    [wself.view showErrorAlert:[NSString stringWithFormat:@"%ld", (long)errorCode]];
                }
            }];
        } else {
            [wself.view showErrorAlert:[NSString stringWithFormat:@"%ld", (long)errorCode]];
        }
    }];
}

- (void)didSaveMemo:(NSNotification *)notification {
    __weak typeof(self) wself = self;
    [self.memoItemRepository readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
        if (errorCode == nil) {
            wself.memos = [Translater memoItemsToMemos:memoItems];
        }
    }];
}

- (void)didSelectItem:(NSIndexPath *)indexPath {
    [self.view transitionDetailMemo:self.memos[indexPath.row]];
}

- (void)tappedUnderRightButton {
    if (self.tableViewEditing) {
        [self.view showAllDeleteActionSheet];
    } else {
        [self.view transitionCreateMemo];
    }
}

- (void)viewDidLoad {
    [self.view setupLayout];
    __weak typeof(self) wself = self;
    [wself.memoItemRepository readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
        if (errorCode == nil) {
            wself.memos = [Translater memoItemsToMemos:memoItems];
        } else {
            [wself.view showErrorAlert:[NSString stringWithFormat:@"%ld", (long)errorCode]];
        }
    }];
}

- (void)viewWillAppear {
    [self.view deselectRowIfNeeded];
}

@end
