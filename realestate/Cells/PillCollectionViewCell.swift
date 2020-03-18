//
//  PillCollectionViewCell.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import UIKit
enum PositionType {
    case province
    case district
    case ward
    case subject
}
protocol PillCellSelectedProtocol {
    func updateList(item: IBaseSqlModel)
}

class PillCollectionViewCell: UICollectionViewCell {
    var delegate: PillCellSelectedProtocol?
    var item: IBaseSqlModel! {
        didSet {
            self.pillText.setTitle(item.name, for: .normal)
            self.pillText.backgroundColor = item.isSelect ? #colorLiteral(red: 0.04500000179, green: 0.5249999762, blue: 0.3610000014, alpha: 1) : UIColor.darkGray
        }
    }
    
    @IBOutlet weak var pillText: CustomUIButton!
    @IBAction func pillSelect(_ sender: Any) {
        delegate?.updateList(item: item)
    }
}
