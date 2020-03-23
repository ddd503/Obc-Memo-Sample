//
//  MemoListPresenterTest.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MemoListPresenter.h"
#import "MemoItemRepositoryMock.h"

// Objective-CでSwitch内でStringを使えるっぽく書く方法
#define CASE(string) if ([__s__ isEqualToString:(string)])
#define SWITCH(s) for (NSString *__s__ = (s); __s__; __s__ = nil)
#define DEFAULT

@interface MemoListPresenterTest : XCTestCase <MemoListPresenterOutputs>
@property (nonatomic) XCTestExpectation * expectation;
@end

@implementation MemoListPresenterTest

// MARK: テスト実行

- (void)test_memos_メモリスト更新時に適切なOutputが走るか {
    self.expectation = [self expectationWithDescription:@"メモリスト更新時に適切なOutputが走るか"];
    MemoItemRepositoryMock * repository = [[MemoItemRepositoryMock alloc] initWith:YES];
    MemoListPresenter * presenter = [[MemoListPresenter alloc] initWith:repository];
    [presenter bind:self];

    NSMutableArray<Memo *> * mutableArray = [NSMutableArray<Memo *> new];
    for(int i=0; i<20; i++){
        Memo * memo = [[Memo alloc] initWith:[NSString stringWithFormat:@"%ld", (long)i]
                                       title:[NSString stringWithFormat:@"%ld", (long)i]
                                     content:[NSString stringWithFormat:@"%ld", (long)i]
                                    editDate:nil];
        [mutableArray addObject:memo];
    }

    presenter.memos = mutableArray;

    [self waitForExpectations:[[NSArray alloc] initWithObjects:self.expectation, nil] timeout:3.0];
}

// MARK: 実行結果の評価

- (void)deselectRowIfNeeded {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)setupLayout {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)showAllDeleteActionSheet {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)showErrorAlert:(NSString *)message {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)transitionCreateMemo {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)transitionDetailMemo:(Memo *)memo {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)updateButtonTitle:(NSString *)title {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"") {
            [self.expectation fulfill];
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)updateMemoList:(NSArray<Memo *> *)memos {
    NSString * string = self.expectation.description;
    SWITCH(string) {
        CASE(@"メモリスト更新時に適切なOutputが走るか") {
            XCTAssertEqual(memos.count, 20);
            [self.expectation fulfill];
            break;
        }
        DEFAULT {
            XCTFail();
            break;
        }
    }
}

- (void)updateTableViewIsEditing:(BOOL)isEditing {
    NSString * string = self.expectation.description;
       SWITCH(string) {
           CASE(@"") {
               [self.expectation fulfill];
           }
           DEFAULT {
               XCTFail();
               break;
           }
       }
}

@end
