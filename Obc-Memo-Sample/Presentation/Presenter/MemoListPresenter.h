//
//  MemoListPresenter.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"
#import "AlertEventType.h"
#import "MemoItemRepository.h"

@protocol MemoListPresenterOutputs <NSObject>
- (void)setupLayout;
- (void)updateMemoList:(NSArray<Memo *> *)memos;
- (void)deselectRowIfNeeded;
- (void)transitionCreateMemo;
- (void)transitionDetailMemo:(Memo *)memo;
- (void)updateTableViewIsEditing:(BOOL)isEditing;
- (void)updateButtonTitle:(NSString *)title;
- (void)showAllDeleteActionSheet;
- (void)showErrorAlert:(NSString *)message;
@end

@protocol MemoListPresenterInputs <NSObject>
@property (nonatomic) NSMutableArray<Memo *> * memos;
@property (nonatomic) BOOL tableViewEditing;
@property (nonatomic) void (^tappedActionSheet)(AlertEventType);
- (void)bind:(NSObject<MemoListPresenterOutputs> *)view;
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)tappedUnderRightButton;
- (void)deleteMemo:(NSString *)uniqueId;
- (void)didSaveMemo:(NSNotification *)notification;
- (void)didSelectItem:(NSIndexPath *)indexPath;
@end

@interface MemoListPresenter : NSObject <MemoListPresenterInputs>
@property (nonatomic, weak) NSObject<MemoListPresenterOutputs> * view;
@property (nonatomic) NSObject<MemoItemRepository> * memoItemRepository;
- (instancetype)initWith:(NSObject<MemoItemRepository> *)memoItemRepository;
@end
