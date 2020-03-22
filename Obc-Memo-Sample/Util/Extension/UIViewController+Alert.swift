//
//  UIViewController+Alert.swift
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/21.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAllDeleteActionSheet(title: String? = nil, message: String? = nil, handler: @escaping (AlertEventType) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let allDelete = UIAlertAction(title: "すべて削除", style: .destructive) { (_) in
            handler(.AllDelete)
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (_) in
            handler(.Cancel)
        }
        alert.addAction(allDelete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }

    func showNormalErrorAlert(message: String? = nil) {
        let message = message ?? "一時的な不具合が発生しました。\n一定時間待ってからお試しください。"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .default, handler: nil)
        alert.addAction(close)
        self.present(alert, animated: true)
    }
}
