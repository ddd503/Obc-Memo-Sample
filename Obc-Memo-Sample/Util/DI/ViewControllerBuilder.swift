//
//  ViewControllerBuilder.swift
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/21.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

final class ViewControllerBuilder {
    static func buildMemoListVC() -> MemoListViewController {
        let memoItemDataStore = MemoItemDataStoreImpl()
        let memoItemRepository = MemoItemRepositoryImpl(memoItemDataStore)
        let memoListPresenter = MemoListPresenter(memoItemRepository)
        return MemoListViewController(presenterInputs: memoListPresenter)
    }

    static func buildMemoDetailVC(memo: Memo? = nil) -> MemoDetailViewController {
        let memoItemDataStore = MemoItemDataStoreImpl()
        let memoItemRepository = MemoItemRepositoryImpl(memoItemDataStore)
        let memoDetailPresenter = MemoDetailPresenter(memoItemRepository, memo: memo)
        return MemoDetailViewController(presenterInputs: memoDetailPresenter)
    }
}
