//
//  MemoListViewController.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoListViewController.h"
#import "MemoInfoCell.h"
#import <Obc_Memo_Sample-Swift.h>

@interface MemoListViewController () <UITableViewDataSource, UITableViewDelegate, MemoListPresenterOutputs>
@property (nonatomic, weak) IBOutlet UIButton * underRightButton;
@property (nonatomic, weak) IBOutlet UILabel * countLabel;
@property (nonatomic, weak) IBOutlet UILabel * emptyLabel;
@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic) NSObject<MemoListPresenterInputs> * presenterInputs;
@end

@implementation MemoListViewController

// MARK: - Propaties

- (void)setTableView:(UITableView *)tableView {
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[MemoInfoCell nib] forCellReuseIdentifier:[MemoInfoCell identifier]];
    tableView.tableFooterView = [UIView new];
}

// MARK: - Inputs

- (instancetype)init {
    return [self initWith:[NSObject<MemoListPresenterInputs> new]];
}

- (instancetype)initWith:(NSObject<MemoListPresenterInputs> *)presenterInputs {
    self = [super initWithNibName:@"MemoListViewController" bundle:NSBundle.mainBundle];
    if (self) {
        self.presenterInputs = presenterInputs;
        [self.presenterInputs bind:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    @throw nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenterInputs viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.presenterInputs viewWillAppear];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    self.presenterInputs.tableViewEditing = editing;
}

- (IBAction)tappedUnderRightButton:(UIButton *)sender {
    [self.presenterInputs tappedUnderRightButton];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MemoInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:[MemoInfoCell identifier]];
    [cell setInfo:self.presenterInputs.memos[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenterInputs.memos.count;
}

// MARK: - Outputs

- (void)deselectRowIfNeeded {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.tableView deselectRowAtIndexPath:wself.tableView.indexPathForSelectedRow animated:YES];
    });
}

- (void)setupLayout {
    self.title = @"メモ";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)showAllDeleteActionSheet {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself showAllDeleteActionSheetWithTitle:nil message:nil handler:wself.presenterInputs.tappedActionSheet];
    });
}

- (void)showErrorAlert:(NSString * _Nullable)message {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself showErrorAlert:message];
    });
}

- (void)transitionCreateMemo {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.navigationController pushViewController:[ViewControllerBuilder buildMemoDetailVCWithMemo:nil] animated:YES];
    });
}

- (void)transitionDetailMemo:(Memo * _Nullable)memo {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.navigationController pushViewController:[ViewControllerBuilder buildMemoDetailVCWithMemo:memo] animated:YES];
    });
}

- (void)updateButtonTitle:(NSString * _Nonnull)title {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.underRightButton setTitle:title forState:UIControlStateNormal];
    });
}

- (void)updateMemoList:(NSArray<Memo *> * _Nonnull)memos {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.tableView reloadData];
        wself.countLabel.text = (memos.count > 0) ? [NSString stringWithFormat:@"%ld件のメモ", (long)memos.count] : @"メモなし";
        if (memos.count <= 0) {
            [wself setEditing:NO animated:YES];
        }
    });
}

- (void)updateTableViewIsEditing:(BOOL)isEditing {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.tableView setEditing:isEditing];
    });
}

@end
