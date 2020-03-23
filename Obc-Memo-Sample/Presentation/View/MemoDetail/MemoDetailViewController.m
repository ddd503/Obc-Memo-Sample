//
//  MemoDetailViewController.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoDetailViewController.h"

@interface MemoDetailViewController () <UITextViewDelegate, MemoDetailPresenterOutputs>
@property (nonatomic, weak) IBOutlet UITextView * textView;
@property (nonatomic) UIBarButtonItem * doneButtonItem;
@property (nonatomic) NSObject<MemoDetailPresenterInputs> * presenterInputs;
@end

@implementation MemoDetailViewController

// MARK: - Propaties

- (void)setTextView:(UITextView *)textView {
    textView.delegate = self;
}

// MARK: - Inputs

- (instancetype)init {
    return [self initWith:[NSObject<MemoDetailPresenterInputs> new]];
}

- (instancetype)initWith:(NSObject<MemoDetailPresenterInputs> *)presenterInputs {
    self = [super initWithNibName:@"MemoDetailViewController" bundle:NSBundle.mainBundle];
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

- (void)tappedDoneButton:(UIBarButtonItem *)sender {
    [self.presenterInputs tappedDoneButton:self.textView.text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    __weak typeof(self) wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wself.presenterInputs didChangeTextView:textView.text];
    });
    return YES;
}

// MARK: - Outputs

- (void)returnMemoList {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.navigationController popViewControllerAnimated:YES];
    });
}

- (void)setupDoneButton {
    self.doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                        target:self
                                                                        action:@selector(tappedDoneButton:)];
    self.navigationItem.rightBarButtonItem = self.doneButtonItem;
    [self.textView becomeFirstResponder];
}

- (void)setupText:(NSString * _Nullable)initialText {
    self.textView.text = initialText;
    [self.presenterInputs didChangeTextView:self.textView.text];
}

- (void)setupTitle:(NSString * _Nonnull)title {
    self.title = title;
}

- (void)showErrorAlert:(NSString * _Nullable)message {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself showErrorAlert:message];
    });
}

- (void)updateDoneButtonState:(BOOL)isEnabled {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself.doneButtonItem setEnabled:isEnabled];
    });
}

@end
