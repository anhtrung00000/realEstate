//
//  DashboardTableViewCell.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 10/9/19.
//  Copyright © 2019 Nguyen Quy Trung. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var roomImage: UIImageView!
    
    @IBOutlet weak var like: UIImageView!
    @IBOutlet weak var roomNam: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var borderView: CustomUIView!
    
    override func awakeFromNib() {
        roomImage.layer.cornerRadius = 10
    }
}
