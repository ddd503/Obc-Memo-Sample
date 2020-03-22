//
//  ViewControllerBuilder.swift
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/22.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

@objc(ViewControllerBuilder)
final class ViewControllerBuilder: NSObject {

    @objc
    static func buildMemoListVC() -> MemoListViewController {
        let memoItemDataStore = MemoItemDataStoreImpl()
        let memoItemRepository = MemoItemRepositoryImpl(memoItemDataStore)
        let memoListPresenter = MemoListPresenter(memoItemRepository)
        return MemoListViewController(memoListPresenter)
    }

    @objc
    static func buildMemoDetailVC(memo: Memo? = nil) -> MemoDetailViewController {
        let memoItemDataStore = MemoItemDataStoreImpl()
        let memoItemRepository = MemoItemRepositoryImpl(memoItemDataStore)
        let memoDetailPresenter = MemoDetailPresenter(memoItemRepository, memo: memo)
        return MemoDetailViewController(memoDetailPresenter)
    }
}
