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
- (void)updateMemoList:(NSArray<Memo *> * _Nonnull)memos;
- (void)deselectRowIfNeeded;
- (void)transitionCreateMemo;
- (void)transitionDetailMemo:(Memo * _Nullable)memo;
- (void)updateTableViewIsEditing:(BOOL)isEditing;
- (void)updateButtonTitle:(NSString * _Nonnull)title;
- (void)showAllDeleteActionSheet;
- (void)showErrorAlert:(NSString *  _Nullable)message;
@end

@protocol MemoListPresenterInputs <NSObject>
@property (nonatomic) NSMutableArray<Memo *> * _Nonnull memos;
@property (nonatomic) BOOL tableViewEditing;
@property (nonatomic) void (^ _Nonnull tappedActionSheet)(AlertEventType);
- (void)bind:(NSObject<MemoListPresenterOutputs> * _Nonnull)view;
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)tappedUnderRightButton;
- (void)deleteMemo:(NSString * _Nonnull)uniqueId;
- (void)didSaveMemo:(NSNotification * _Nullable)notification;
- (void)didSelectItem:(NSIndexPath * _Nullable)indexPath;
@end

@interface MemoListPresenter : NSObject <MemoListPresenterInputs>
@property (nonatomic, weak) NSObject<MemoListPresenterOutputs> * _Nullable view;
@property (nonatomic) NSObject<MemoItemRepository> * _Nonnull memoItemRepository;
- (instancetype _Nonnull)initWith:(NSObject<MemoItemRepository> * _Nonnull)memoItemRepository;
@end
