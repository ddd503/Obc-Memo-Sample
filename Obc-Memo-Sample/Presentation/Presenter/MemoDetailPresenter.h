//
//  MemoDetailPresenter.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/21.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"
#import "MemoItemRepository.h"

@protocol MemoDetailPresenterOutputs <NSObject>
- (void)setupText:(NSString * _Nullable)initialText;
- (void)setupTitle:(NSString * _Nonnull)title;
- (void)setupDoneButton;
- (void)returnMemoList;
- (void)showErrorAlert:(NSString * _Nullable)message;
- (void)updateDoneButtonState:(BOOL)isEnabled;
@end

@protocol MemoDetailPresenterInputs <NSObject>
- (void)bind:(NSObject<MemoDetailPresenterOutputs> * _Nonnull)view;
- (void)viewDidLoad;
- (void)tappedDoneButton:(NSString * _Nonnull)textViewText;
- (void)didSaveMemo:(NSNotification * _Nonnull)notification;
- (void)didChangeTextView:(NSString * _Nonnull)text;
@end

@interface MemoDetailPresenter : NSObject<MemoDetailPresenterInputs>
@property (nonatomic, weak) NSObject<MemoDetailPresenterOutputs> * _Nullable view;
@property (nonatomic) NSObject<MemoItemRepository> * _Nonnull memoItemRepository;
@property (nonatomic) Memo * _Nullable memo;
- (instancetype _Nonnull )initWith:(NSObject<MemoItemRepository> * _Nonnull) memoItemRepository
                              memo:(Memo * _Nullable)memo;
@end
