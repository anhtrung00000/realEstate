//
//  Ward.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
class Ward : BaseSqlModel {
    var districtId: Int = 0
    init(id: Int, name: String, type: String, districtId: Int) {
        super.init(id: id, name: name, type: type, hiarche: .ward)
        self.districtId = districtId
    }
    
}
