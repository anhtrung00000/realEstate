//
//  District.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
class District: BaseSqlModel {
    
    var provinceId: Int = 0
     init(id: Int, name: String, type: String,  provinceId: Int) {
        super.init(id: id, name: name, type: type, hiarche: .district)
        self.provinceId = provinceId
    }
}
