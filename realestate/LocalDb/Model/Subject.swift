//
//  Subject.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 3/3/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
class Subject : BaseSqlModel {
    init(id: Int, name: String) {
        super.init(id: id, name: name, type: "", hiarche: .subject)
//        self.districtId = districtId
    }
}
