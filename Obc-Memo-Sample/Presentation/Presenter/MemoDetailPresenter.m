//
//  MemoDetailPresenter.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/21.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoDetailPresenter.h"

@implementation MemoDetailPresenter

- (instancetype _Nonnull )initWith:(NSObject<MemoItemRepository> * _Nonnull) memoItemRepository
                              memo:(Memo * _Nullable)memo {
    self = [super init];
    if (self) {
        self.memoItemRepository = memoItemRepository;
        self.memo = memo;
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(didSaveMemo:)
                                                   name:NSManagedObjectContextDidSaveNotification
                                                 object:nil];
    }
    return self;
}

- (void)bind:(NSObject<MemoDetailPresenterOutputs> * _Nonnull)view {
    self.view = view;
}

- (void)didChangeTextView:(NSString * _Nonnull)text {
    [self.view updateDoneButtonState:!([text isEqualToString:@""])];
}

- (void)didSaveMemo:(NSNotification * _Nonnull)notification {
    [self.view returnMemoList];
}

- (void)tappedDoneButton:(NSString * _Nonnull)textViewText {
    if (self.memo != nil) {
        // 既存メモの更新
        [self.memoItemRepository updateMemoItem:self.memo.uniqueId
                                           text:textViewText
                                     completion:^(void * _Nullable (_)(void),
                                                  NSInteger * _Nullable errorCode) {
            if (errorCode != nil) {
                [self.view showErrorAlert:@"failed update memo"];
            }
        }];
    } else {
        // 新規メモの作成
        [self.memoItemRepository createMemoItem:textViewText
                                       uniqueId:nil
                                     completion:^(MemoItem * _Nullable memoItem,
                                                  NSInteger * _Nullable errorCode) {
            if (errorCode != nil) {
                [self.view showErrorAlert:@"failed update memo"];
            }
        }];
    }
}

- (void)viewDidLoad {
    NSString * initialText = (self.memo == nil) ? @"" : [NSString stringWithFormat:@"%@\n%@",
                                                         self.memo.title, self.memo.content];
    [self.view setupText:initialText];
    NSString * title = (self.memo == nil) ? @"新規メモ" : self.memo.title;
    [self.view setupTitle:title];
    [self.view setupDoneButton];
}

@end
