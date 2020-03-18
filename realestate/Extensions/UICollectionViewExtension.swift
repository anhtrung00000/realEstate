//
//  UICollectionViewExtension.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/28/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
    func showEmptyMessageWhenNoneData(isShow: Bool) {
        self.backgroundView?.alpha = isShow ? 0 :  1
    }
    
}
