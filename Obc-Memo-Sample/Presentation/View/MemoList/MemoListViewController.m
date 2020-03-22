//
//  MemoListViewController.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoListViewController.h"
#import "MemoInfoCell.h"

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
//    self = [super init];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {}
- (void)setEditing:(BOOL)editing {
    [super setEditing:editing];
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

}

- (void)setupLayout {

}

- (void)showAllDeleteActionSheet {

}

- (void)showErrorAlert:(NSString * _Nullable)message {

}

- (void)transitionCreateMemo {

}

- (void)transitionDetailMemo:(Memo * _Nullable)memo {

}

- (void)updateButtonTitle:(NSString * _Nonnull)title {

}

- (void)updateMemoList:(NSArray<Memo *> * _Nonnull)memos {

}

- (void)updateTableViewIsEditing:(BOOL)isEditing {
    
}

@end
